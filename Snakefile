config = {
    "build_dir": "../../publishable-circles",
    "input_dir": "../../private-circles"
}

BUILD_DIR = config['build_dir']
INPUT_DIR = config['input_dir']

BAG_WILD = glob_wildcards(INPUT_DIR + "/{vin,.{17}}/bagfiles/{day_folder,.{10}}/{name}.{ext, bag|bag.active}")
OUTPUT_FILES = expand(BUILD_DIR + "/{vin}/bagfiles/{day_folder}/{name}.{ext}", zip, day_folder=BAG_WILD.day_folder, name=BAG_WILD.name, vin=BAG_WILD.vin, ext=BAG_WILD.ext)

rule all:
    input:
        OUTPUT_FILES

rule copy:
    input:
        INPUT_DIR + "/{vin}/bagfiles/{day_folder}/{name}.{ext}"
    output:
        BUILD_DIR + "/{vin}/bagfiles/{day_folder}/{name}.{ext, bag|bag.active}"
    shell:
        """
        cp {input} {output}
        """