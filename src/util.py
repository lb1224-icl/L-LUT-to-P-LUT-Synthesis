import numpy as np

def generate_tt_hex(path, n_inputs=16, seed=42):
    np.random.seed(seed)

    n_bits = 2 ** n_inputs  

    # Random Boolean function (0/1)
    tt = np.random.randint(0, 2, size=n_bits, dtype=np.uint8)

    # Pack bits into a single integer
    value = 0
    for i, bit in enumerate(tt):
        value |= int(bit) << i

    hex_len = n_bits // 4 
    hex_str = format(value, f"0{hex_len}x")

    with open(path, "w") as f:
        f.write("# L-LUT truth table\n")
        f.write("# N_INPUTS = 16\n")
        f.write("# BIT_ORDER = x15 x14 ... x0 (x0 = LSB)\n")
        f.write("HEX = " + hex_str + "\n")

    print(f"Wrote {hex_len} hex chars to {path}")

def load_tt_hex(path, n_inputs):
    n_bits = 2 ** n_inputs
    expected_hex_len = n_bits // 4

    with open(path, "r") as f:
        for line in f:
            line = line.strip()
            if line.startswith("HEX"):
                hex_str = line.split("=", 1)[1].strip() #separate at first "=" and remove leading space
                break
        else:
            raise ValueError("HEX line not found")

    if len(hex_str) != expected_hex_len:
        raise ValueError(
            f"Expected {expected_hex_len} hex chars, got {len(hex_str)}"
        )

    value = int(hex_str, 16)

    # Unpack bits into NumPy array
    tt = np.zeros(n_bits, dtype=np.uint8)
    for i in range(n_bits):
        tt[i] = (value >> i) & 1

    return tt


def eval_tt(tt, x):
    index = 0
    for i, bit in enumerate(x):
        if bit:
            index |= (1 << i)
    return tt[index]

generate_tt_hex("data/truth_table_16.hex", n_inputs=16, seed=122)
tt = load_tt_hex("data/truth_table_16.hex", n_inputs=16)

