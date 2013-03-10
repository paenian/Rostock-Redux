module beltTensioner(belt_width, post_width, length, thickness, notch_depth)
{
	module _beltTensioner(width, length, thickness, post_width, notch_depth)
	{
		cutout_width = width - post_width + 2;
		cutout_length = (length - post_width * 3) / 2;
		cutout_thickness = thickness + 6;

		notch_width = width - post_width * 2;
		module cutout()
		{
			translate([post_width / 2 + 1, length / 2 - cutout_length / 2 - post_width, 0])
			{
				cube([cutout_width, cutout_length, cutout_thickness], center=true);
			}
		}
	
		module notch_cutout()
		{
			translate([0,  length / 2 - post_width / 2, thickness / 2 - notch_depth / 2 + 1])
			{
				cube([notch_width, post_width + 2, notch_depth + 2], center= true);
			}
		}
		difference()
		{
			// Main body	
			cube([width, length, thickness], center=true);
	
			// Notches for "S" shape
			union()
			{
					cutout ();
					mirror([1, 0, 0])
					{
						mirror([0, 1, 0])
						{
							cutout ();
						}
					}
	
					// Notches for belt guide
					notch_cutout();
					mirror([0, 1, 0])
					{
						notch_cutout();
					}
			}
		}
	}
	_beltTensioner(belt_width + post_width * 2, length, thickness, post_width, notch_depth);
}
beltTensioner(3, 3, 20, 4, 1.5);
