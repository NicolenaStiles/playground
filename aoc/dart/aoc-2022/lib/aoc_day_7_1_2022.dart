import 'dart:io';

void partOne() {
    // load from file
    var inputTest = File('input-day-7-test');
    var inputFile = File('input-day-7');

    bool isDebug = false;
    List<String> readIn = [];
    if (isDebug) {
        readIn = inputTest.readAsLinesSync();
    } else {
       readIn = inputFile.readAsLinesSync();
    }

    // metadata for the "filesystem" 
    String pwd = "";
    final re = RegExp(r'\/');

    // load dirs and files onto disk 
    Map disk = {};
    for(var c in readIn) {
        List<String> cmd = c.split(" ");
        if (cmd[0] == "\$") {
            // cmd: cd
            if(cmd[1] == "cd") {
                // cmd: cd UP
                if (cmd[2] == "..") {
                    List<String> parsePwd = pwd.split(re);
                    String exitingDir = "${parsePwd[parsePwd.length - 2]}/";
                    pwd = pwd.substring(0, pwd.lastIndexOf(exitingDir));
                // cmd: cd DOWN
                } else {
                    // first pass: pwd == ""
                    if (pwd.isEmpty) {
                        pwd = cmd[2];
                        disk[pwd] = 0;
                    } else {
                        pwd = "$pwd${cmd[2]}/";
                        if (!disk.containsKey(pwd)) {
                            disk[pwd] = 0;
                        }
                    }
                }
            }        
        } else if (cmd[0] == "dir" ) {
            String dirName = "$pwd${cmd[1]}/";
            if (!disk.containsKey(dirName)) {
                disk[dirName] = 0;
            }
        } else {
            String fileName = "$pwd${cmd[1]}";
            if(!disk.containsKey(fileName)) {
                disk[fileName] = int.parse(cmd[0]);
            }
        }
    }

    // find files and add their file sizes to that of directories above them
    for (String f in disk.keys) {
        if (f[f.length - 1] != "/") {
          String testPath = "";
          List<String> parentDirs = f.split(re);
          parentDirs = parentDirs.sublist(0,parentDirs.length - 1); 
          for (String d in parentDirs) {
            testPath += "$d/" ;
            disk[testPath] += disk[f];
          }
        }
    }

    // find dirs with filesize <= 100000 and sum those values
    num filesizeSum = 0;
    for(String d in disk.keys) {
        if (d[d.length - 1] == "/") {
            if(disk[d] <= 100000) {
                filesizeSum += disk[d];
            }
        }
    }
    print(filesizeSum);
}
