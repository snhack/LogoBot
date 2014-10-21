#!/usr/bin/env python

import os
import openscad
import shutil
import sys
import c14n_stl

from bom import source_dir

def bom_to_stls(assembly = None):
    #
    # Make a list of all the stls in the BOM
    #
    stl_files = []
    if assembly:
        bom = "accessories/%s.txt" % assembly
    else:
        bom = "bom.txt"
    for line in open("bom/" + bom, "rt").readlines():
        words = line.split()
        if words:
            last_word = words[-1]
            if len(last_word) > 4 and last_word[-4:] == ".stl":
                stl_files.append(last_word)
    return stl_files

def stls(parts = None):
    #
    # Make the target directory
    #
    target_dir = "stl"
    if not os.path.isdir(target_dir):
        os.makedirs(target_dir)

    #
    # Decide which files to make
    #
    if parts:
        targets = list(parts)           #copy the list so we dont modify the list passed in
    else:
        targets = bom_to_stls()
    
    #
    # Find all the scad files
    #
    used = []
    for filename in os.listdir(source_dir):
        if filename[-5:] == ".scad":
            #
            # find any modules ending in _stl
            #
            for line in open(source_dir + "/" + filename, "r").readlines():
                words = line.split()
                if(len(words) and words[0] == "module"):
                    module = words[1].split('(')[0]
                    stl = module.replace("_STL", ".stl")
                    if stl in targets:
                        #
                        # make a file to use the module
                        #
                        stl_maker_name = source_dir + "/stl.scad"
                        f = open(stl_maker_name, "w")
                        f.write("include <../config/config.scad>\n")
                        f.write("UseSTL=false;\n");
                        f.write("DebugConnectors=false;\n");
                        f.write("DebugCoordinateFrames=false;\n");
                        f.write("%s();\n" % module);
                        f.close()
                        #
                        # Run openscad on the created file
                        #
                        stl_name = target_dir + "/" + module[:-4] + ".stl"
                        openscad.run("-D$bom=1","-o", stl_name, stl_maker_name)
                        c14n_stl.canonicalise(stl_name)
                        targets.remove(stl)
                        #
                        # Add the files on the BOM to the used list for plates.py
                        #
                        for line in open("openscad.log"):
                            if line[:7] == 'ECHO: "' and line[-6:] == '.stl"\n':
                                used.append(line[7:-2])
    #
    # List the ones we didn't find
    #
    for module in targets:
        print("Could not find", module)
    return used

if __name__ == '__main__':
    stls()
