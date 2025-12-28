import pathlib
N=10; out_w=24; bases=[0x1,0x3]; max_shift=4
entries=1<<N; bits=0; mask=(1<<out_w)-1
for i in range(entries):
    base=bases[i%len(bases)]
    shift=(i//len(bases))%max_shift
    val=(base<<shift)&mask  # left-shifted base, right-shiftable by TRSH
    for b in range(out_w):
        bits |= ((val>>b)&1) << (i*out_w+b)
hex_body=f"{bits:0{entries*out_w//4}X}"
path=pathlib.Path("data/clut_heavy_reuse.hex")
path.write_text(f"# FANIN = {N}\n# IN_WIDTH = 1\n# OUT_WIDTH = {out_w}\nHEX = {hex_body}\n")
print("wrote", path)