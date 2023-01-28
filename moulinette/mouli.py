import zipfile
import os
import shutil
import subprocess
import tempfile

# Name of the file: directory dest
#   Myfiles used for correcting
test2copy = {
    "Makefile": "",
    "fibonnaci.c": "fibonnaci/",
    "filetoxor.bin": "myfilexor/",
    "myadd.c": "myadd/",
    "mydiv.c": "mydiv/",
    "myfilexor.c": "myfilexor/",
    "myitoa.c": "myitoa/",
    "mymul.c": "mymul/",
    "myorderlist.c": "myorderlist/",
}

# Files provided by the student
#   path_in_zip: path_in_result
student2copy = {
    "asm2022/AUTHOR": "AUTHOR",
    "asm2022/AUTHORS": "AUTHOR", # duplicate for being nice
    "asm2022/fibonnaci/fibonnaci.S": "fibonnaci/fibonnaci.S",
    "asm2022/myadd/myadd.S": "myadd/myadd.S",
    "asm2022/mydiv/mydiv.S": "mydiv/mydiv.S",
    "asm2022/myfilexor/myfilexor.S": "myfilexor/myfilexor.S",
    "asm2022/myitoa/myitoa.S": "myitoa/myitoa.S",
    "asm2022/mymul/mymul.S": "mymul/mymul.S",
    "asm2022/myorderlist/myorderlist.S": "myorderlist/myorderlist.S",
}

student2copy2 = {    
    "AUTHOR": "AUTHOR",
    "AUTHORS": "AUTHOR", # duplicate for being nice
    "fibonnaci/fibonnaci.S": "fibonnaci/fibonnaci.S",
    "myadd/myadd.S": "myadd/myadd.S",
    "mydiv/mydiv.S": "mydiv/mydiv.S",
    "myfilexor/myfilexor.S": "myfilexor/myfilexor.S",
    "myitoa/myitoa.S": "myitoa/myitoa.S",
    "mymul/mymul.S": "mymul/mymul.S",
    "myorderlist/myorderlist.S": "myorderlist/myorderlist.S",
}

possible_student = [student2copy, student2copy2]

# Executable list
#   Those are also the rules for the makefile used in compile
exelist = [
    "myadd/myadd",
    "mymul/mymul",
    "fibonnaci/fibonnaci",
    "mydiv/mydiv",
    "myitoa/myitoa",
    "myorderlist/myorderlist",
    "myfilexor/myfilexor",
]

exe_result = {
    'myadd/myadd': b'myadd(3, 6)=0x9\nmyadd(-1, 6)=0x5\n',
    'mymul/mymul': b'mymul(3, 6); res.high=0x0, res.low=0x12\nmymul(0x1000000000000000, 4); res.high=0x0, res.low=0x4000000000000000\nmymul(0x1000000000000000, 0x10); res.high=0x1, res.low=0x0\n',
    'fibonnaci/fibonnaci': b'fibonnaci(8)=21\nfibonnaci(-5)=-1\n',
    'mydiv/mydiv': b'mydiv(6, 3); res.res=0x2, res.rest=0x0, r=1\nmydiv(6, 4); res.res=0x1, res.rest=0x2, r=1\nmydiv(6, 0); res.res=0x0, res.rest=0x0, r=0\n',
    'myitoa/myitoa': b'myitoa("5")=5\nmyitoa("-5")=-5\nmyitoa("-18")=-18\n',
    'myorderlist/myorderlist': b'3, 8, 16\n',
    'myfilexor/myfilexor': b'myfilexor("filetodexor.bin", 0x42)=Congratulation you have unxor the file\n'
}

############### SETUP ##############

def setup_folder(dst, src_zip, test_path, verbose=True):
    """
        This function performs the following steps:

        1. unzip the ``src_zip`` file
        2. copy ``student2copy`` files into ``dst``
           This will actually try for each directory present in the ``possible_student`` list
        3. copy the ``test2copy`` files from ``test_path`` into ``dst``

        :param verbose: If true will print missing files if they occur.
        :return: True if everything worked as expected, False otherwise. 
    """
    # check we have indeed a zip file
    if not zipfile.is_zipfile(src_zip):
        if verbose: print("    Error {} is not a zip file".format(src_zip))
        return False
    # extract the content of the zip file
    ffound = False
    for s2cpy in possible_student:
        with zipfile.ZipFile(src_zip) as zf:
            for k, v in s2cpy.items():
                try:
                    f = zf.open(k)
                except KeyError:
                    if verbose: print("    No {} in {} (ignoring)".format(k, src_zip))
                    continue
                ffound = True
                ctt = f.read()
                f.close()
                pa = os.path.join(dst, v)
                try:
                    os.makedirs(os.path.dirname(pa))
                except FileExistsError:
                    pass
                f = open(pa, "wb")
                f.write(ctt)
                f.close()
            if ffound: # if at least one file was found we stop
                break
    if not ffound:
        return False
    # copy the files from the test folder
    for k, v in test2copy.items():
        s = os.path.join(test_path, k)
        d = os.path.join(dst, v)
        try:
            os.makedirs(d)
        except FileExistsError:
            pass
        shutil.copy(s, d)
    return True

######################### COMPILATION ##########################

def compile_make(test_path, verbose=False):
    """
        Call the make file in ``test_path`` with each rule in ``exelist``

        If verbose is True, will print the ouptut of make, otherwise will not
        treat it.
    """
    for r in exelist:
        if verbose:
            subprocess.run(["make", "-C", test_path, r])
        else:
            subprocess.run(["make", "-C", test_path, r], stdout=subprocess.PIPE, stderr=subprocess.PIPE)

######################## LAUNCH & CHECK ########################


def execute(test_path, exe, timeout=5, verbose=True):
    """
        Launch the executable ``exe``  from ``test_path`` and return its output.
        If the file was not present or an other error occur return ``None``.
    """
    pa = os.path.join(test_path, exe)
    try:
        p = subprocess.Popen([pa], stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except FileNotFoundError:
        return None
    try:
        outs, errs = p.communicate(timeout=5)
    except subprocess.TimeoutExpired:
        if verbose: print("    {} has timeout".format(exe))
        return None
    return outs

def launch_all(test_path):
    """
        Launch all executable from ``exelist`` and return the result as a dict ``exe_name: output``
        with output the string resulting or None if the process did not work.
    """
    d = {}
    for exe in exelist:
        d[exe] = execute(test_path, exe)
    return d

#print(launch_all("./test"))
#print(launch_all("../corrections"))

def compare_result(test_path):
    """
        Launch all executable (see :func:`launch_all`) and compare
        the results to ``exe_result``.

        Return a dict containing the result ``exe_name: BOOL`` with BOOL being
        ``True`` if the result match and False otherwise.
    """
    res = launch_all(test_path)
    d = {}
    for k, v in res.items():
        d[k] = exe_result[k] == v
    return d

#print(compare_result("./test"))

def store_result(test_path, result_file, verbose=True):
    """
        From a ``test_path`` will:

        1. read the AUTHOR file for getting the name
        2. launch all exe and compare the result (:func:`compare_result`)
        3. store the result in ``result_file`` as
            ``AUTHOR, EXO1, EXO2, ...`` with the exo in order of ``exelist``
    """
    d = compare_result(test_path)
    try:
        with open(os.path.join(test_path, "AUTHOR"), "r") as f:
            author = f.readline().strip()
    except FileNotFoundError:
        if verbose: print("    No AUTHOR file!")
        s = "None, "
        s += ", ".join(["None" for _ in exelist])
        with open(result_file, "a") as f:
            f.write(s + "\n")
        return
    s = author + ", "
    s += ", ".join([str(d[exe]) for exe in exelist])
    with open(result_file, "a") as f:
        f.write(s + "\n")


################### MAIN ##########################

def init_csv(result_file):
    s = "author, "
    s += ", ".join(exelist)
    with open(result_file, "w") as f:
        f.write(s + "\n")

#init_csv("res.csv")
#store_result("./test", "res.csv")

def test_one_zip(csv_result, dir_zip, zip_file, test_dir, verbose=True):
    if verbose: print("Treating {}".format(zip_file))
    pa_zip = os.path.join(dir_zip, zip_file)
    d = tempfile.mkdtemp()
    if not setup_folder(d, pa_zip, test_dir, verbose=verbose):
        print("MAIN ERROR for {}".format(zip_file))
        return False
    compile_make(d)
    store_result(d, csv_result, verbose=verbose)
    shutil.rmtree(d)
    return True


def launch_correction(csv_result, dir_zip, test_dir, verbose=True):
    """
        Launch all test for all zip file in the ``dir_zip`` directory and store
        result in a new file ``csv_result``. Files use for testing are fetch
        from test_dir
    """
    # init csv
    init_csv(csv_result)

    # treat all zip files
    for zip_file in os.listdir(dir_zip):
        test_one_zip(csv_result, dir_zip, zip_file, test_dir, verbose=verbose)

launch_correction("res.csv", "input/", "../for_test")
