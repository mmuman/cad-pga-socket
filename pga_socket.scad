// Idea and draft code by max1zzz (@max234252).


/*[Variant]*/
pga_which = 128; // [128:128 pins - MC68030]


/*[Debug]*/

$fn = 16;

/*[Hidden]*/

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

module pga_socket(pga) {
    pitch=2.54;
    margin = 0;

    module pin_array(pga, o = 0, cavity=false) {
        fn = cavity ? ($preview ? 8 : $fn) : 4;
        for(y=[0:1:pga.y-1],x=[0:1:pga.x-1]){
            if (pga.z[pga.y-y-1][x] == "1") {
                translate([pitch*(x+.5), pitch*(y+.5), 0]){
                    translate([0, 0, -.1])
                        cylinder(2.2+.2, 0.7, 0.7, $fn=fn);
                    translate([0, 0, 2.2])
                        cylinder(0.9, 0.9, $fn=fn);
                    // speed up rendering, that's just for the preview
                    if (!cavity) {
                        translate([0, 0, -3])
                            cylinder(4, 0.2, 0.2);
                        translate([0, 0, 3])
                            difference() {
                                cylinder(0.5, 0.9, 0.9);
                                translate([0,0,.1]) cylinder(1, 0.6, 0.6);
                            }
                    }
                }
            }
        }
    }

    if ($preview)
        color("Goldenrod") pin_array(pga, margin);

    difference() {
        cube([pitch*pga.x, pitch*pga.y, 3]);
        pin_array(pga, margin, true);
    }
};

idx = search(128, pga_pins, num_returns_per_match=0, index_col_num=3);
pga_socket(pga_pins[idx[0]]);
