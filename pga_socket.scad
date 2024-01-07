

pga_which = 128; // [128]

pga_pins = [
    // [ x, y, pins, count ]
    [
        13, 13,
        [
            "1111111111111",
            "1111111111111",
            "1111111111111",
            "1111010001111",
            "1110000000111",
            "1110000000111",
            "1110000000111",
            "1110000000111",
            "1111000001111",
            "1111010001111",
            "1111111111111",
            "1111111111111",
            "1111111111111"
        ],
        128
    ]
];

module pga_mask(pga) {
    pitch=2.54;
    echo (pga.x, pga.y);
    difference() {
        cube([33, 33, 3]);
        for(y=[0:1:pga.y-1],x=[0:1:pga.x-1]){
            echo(y, x, pga.z[y][x]);
            if (pga.z[pga.y-y-1][x] == "1") {
                translate([pitch*(x+.5), pitch*(y+.5), -0.1]){
                    cylinder(2.2+.2, 0.7, 0.7, $fn=16);
                    translate([0, 0, 2.2+.1])
                        cylinder(0.9, 0.9, $fn=16);
                }
            }
        }
    }
};

idx = search(128, pga_pins, num_returns_per_match=0, index_col_num=3);
pga_mask(pga_pins[idx[0]]);

