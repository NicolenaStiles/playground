import 'dart:io';

class ElfFile {
    String filename = "";
    int filesize = 0;
}

class ElfDirectory {
    String name;
    int filesize;
    int depth;
    String parentName;
    Map<String,ElfDirectory> childDirs = {};
    Map<String,ElfFile> childFiles = {};

    ElfDirectory(this.name, this.filesize, this.depth, this.parentName, this.childDirs, this.childFiles);
}

void partOne() {
    // load from file
    var inputFile = File('input-day-7');
    List<String> readIn = inputFile.readAsLinesSync();

    // DEBUG ONLY
    // split into test and actual data
    List<String> testCmds = readIn.sublist(0, 23);

    // metadata for the "filesystem" 
    String pwd = "";
    String prevDir = "";
    int currDepth = 0;

    // tracks dirs/files 
    Map disk = {};
    // tracks the filesystem depth structure
    List<List<String>> tracker = [];
    for(var c in testCmds) {
        List<String> cmd = c.split(" ");
        if (cmd[0] == "\$") {
            // cmd: cd
            if(cmd[1] == "cd") {
                // cmd: cd UP
                if (cmd[2] == "..") {
                    String temp = pwd;
                    pwd = prevDir;
                    prevDir = temp;
                    currDepth--;
                // cmd: cd DOWN
                } else {
                    prevDir = pwd;
                    pwd = cmd[2];
                    if (tracker.isEmpty) {
                        tracker.add([pwd]);
                        disk[pwd] = ElfDirectory(pwd, 0, currDepth, prevDir, {}, {}); 
                    } else {
                        currDepth++;
                        if (tracker.length - 1 < currDepth) {
                            disk[pwd] = ElfDirectory(pwd, 0, currDepth, prevDir, {}, {}); 
                            tracker.add([pwd]);
                        } else {
                            if (!tracker[currDepth].contains(pwd)) {
                                disk[pwd] = ElfDirectory(pwd, 0, currDepth, prevDir, {}, {}); 
                                tracker[currDepth].add(pwd);
                            }
                        }
                    }
                }
            }        
        } else if (cmd[0] == "dir") {
            // this is wrong. ignore this.
            if (!disk[pwd].childDirs.containsKey(cmd[1])) {

            }
        } else {

        }
    }
    // DEBUG
    for (var d in tracker) {
        print(d);
    }
    print(disk.keys);
}
