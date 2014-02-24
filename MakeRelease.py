import sys, os, shutil, traceback, re, subprocess
from glob import glob
import datetime

todaystr = datetime.date.today().strftime("%Y.%m.%d")

textExts = ['.txt', '.ahk', '.py']
excludeExts = ['.swp']

Ahk2ExePath = r'C:\Program Files (x86)\AutoHotkey\Compiler\Ahk2Exe.exe'
MakeNSISPath = r"C:\Program Files (x86)\NSIS\makensis.exe"

def mktree(dirPath):
    toks = list(os.path.split(dirPath))
    path = ""
    while toks:
        path = os.path.join(path, toks.pop(0))
        if not path: continue
        if not os.path.exists(path):
            os.mkdir(path)
        else:
            assert os.path.isdir(path)

def matchany(patterns, string):
    for pattern in patterns:
        if re.match(pattern, string):
            return True
    return False

def MakeRelease(**kwargs):
    makeExe     = kwargs.pop('makeExe', "")
    makeNSIS    = kwargs.pop('makeNSIS', [])
    exclude     = kwargs.pop('exclude', [])
    headerPath  = kwargs.pop('header', r'Header.txt')
    outDir      = kwargs.pop('outDir', r'release')
    srcDir      = kwargs.pop('srcDir', r'src')
    srcDirSplit = [d for d in os.path.split(srcDir) if d]
    iconPath    = kwargs.pop('iconPath', '')

    print "Building %s" % (outDir)
    if exclude: print "Excluding %s" % (", ".join(exclude))
    
    if os.path.exists(outDir):
        shutil.rmtree(outDir)
    mktree(outDir)


    headerFile = None
    try:
        headerFile = open(headerPath, 'r')
        header = headerFile.read()
        header = header.replace("<DATESTR>", todaystr)
    except:
        print "Failed to read header file '%s':\n" % (headerPath)
        traceback.print_tb()
        sys.exit(1)
    finally:
        if headerFile: headerFile.close()

    for root, dirs, files in os.walk(srcDir):
        for fileName in files:
            fileExt  = os.path.splitext(fileName)[1]
            filePath = os.path.join(root, fileName)
            if matchany(exclude, filePath):
                continue
            fileDir = os.path.dirname(filePath)
            assert fileDir.startswith(srcDir)
            
            fileDirSplit = [d for d in os.path.split(fileDir) if d]
            fileDirSplit = fileDirSplit[len(srcDirSplit):]
            
            dstDir = os.path.join(outDir, *fileDirSplit)
            mktree(dstDir)
            
            dstPath = os.path.join(dstDir, fileName)

            if fileExt in textExts and fileName != 'License.txt':
                print "TEXT:    %s" % (dstPath)
                CopyFileWithHeader(filePath, dstPath, header)
            elif fileExt not in excludeExts:
                print "BINARY:  %s" % (dstPath)
                shutil.copy(filePath, dstPath)
            else:
                print "SKIP:    %s" % (filePath)

    if makeExe:
        MakeExe(os.path.join(outDir, makeExe), iconPath)

    if makeNSIS:
        for nsisScript in makeNSIS:
            MakeNSIS(nsisScript)

    print "Done!"

def CopyFileWithHeader(srcPath, dstPath, header):
    src = open(srcPath, 'r')
    dst = open(dstPath, 'w')
    try:
        for line in header:
            dst.write(line)
        for line in src:
            dst.write(line)
    except:
        traceback.print_tb()
        sys.exit(1)
    finally:
        src.close()
        dst.close()

def MakeExe(filePath, iconPath=''):
    if not os.path.exists(Ahk2ExePath):
        raise Exception("Ahk2Exe not found at '%s'. Set python var Ahk2ExePath." % Ahk2ExePath)
    print "Compiling '%s' with ahk2exe..." % (filePath)
    args = [Ahk2ExePath, '/in', filePath]
    if iconPath:
        args+= ['/icon', iconPath]
    subprocess.call(args,
                    stderr=subprocess.PIPE, stdout=subprocess.PIPE)

def MakeNSIS(filePath):
    if not os.path.exists(MakeNSISPath):
        raise Exception("No makensis found at '%s'. Set python var MakeNSISPath." % MakeNSISPath)
    print "Compiling '%s' with makensis..." % (filePath)
    args = [MakeNSISPath, "/V2", "/DVERSION_STR=%s" % (todaystr,), filePath]
    #ret = subprocess.call(args, stderr=subprocess.PIPE, stdout=subprocess.PIPE)
    proc = subprocess.Popen(args, stderr=subprocess.PIPE, stdout=subprocess.PIPE, shell=False)
    output = proc.stdout.read()
    if len(output) > 0:
        print "\n%s" % (output.replace('\r', ''),)
        raise Exception("makensis failed. Log printed above.")

if __name__ == "__main__":
    MakeRelease(outDir   = 'release',
                makeExe  = "UAWKS.ahk",
                makeNSIS = ["UAWKS.nsi", "UAWKS Source.nsi"],
		iconPath = "release\UAWKS.ico")
