if did_filetype()
    finish
endif
if getline(1) =~# '^#!.*/bin/bash'
    setfiletype bash
endif
