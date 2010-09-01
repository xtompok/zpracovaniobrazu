# Copyright (c) 1997-2009 by Secret Labs AB.  All rights reserved.
# Copyright (c) 1995-2009 by Fredrik Lundh.
#
# See the README file for information on usage and redistribution.
#
# transforms
AFFINE = 0
EXTENT = 1
PERSPECTIVE = 2
QUAD = 3
MESH = 4


    ##
    # Returns a resized copy of this image.
    #
    # @def resize(size, filter=NEAREST)
    # @param size The requested size in pixels, as a 2-tuple:
    #    (width, height).
    # @param filter An optional resampling filter.  This can be
    #    one of <b>NEAREST</b> (use nearest neighbour), <b>BILINEAR</b>
    #    (linear interpolation in a 2x2 environment), <b>BICUBIC</b>
    #    (cubic spline interpolation in a 4x4 environment), or
    #    <b>ANTIALIAS</b> (a high-quality downsampling filter).
    #    If omitted, or if the image has mode "1" or "P", it is
    #    set <b>NEAREST</b>.
    # @return An Image object.

    def resize(self, size, resample=NEAREST):
        "Resize image"

        if resample not in (NEAREST, BILINEAR, BICUBIC, ANTIALIAS):
            raise ValueError("unknown resampling filter")

        self.load()

        if self.mode in ("1", "P"):
            resample = NEAREST

        if resample == ANTIALIAS:
            # requires stretch support (imToolkit & PIL 1.1.3)
            try:
                im = self.im.stretch(size, resample)
            except AttributeError:
                raise ValueError("unsupported resampling filter")
        else:
            im = self.im.resize(size, resample)

        return self._new(im)

    ##
    # Returns a rotated copy of this image.  This method returns a
    # copy of this image, rotated the given number of degrees counter
    # clockwise around its centre.
    #
    # @def rotate(angle, filter=NEAREST)
    # @param angle In degrees counter clockwise.
    # @param filter An optional resampling filter.  This can be
    #    one of <b>NEAREST</b> (use nearest neighbour), <b>BILINEAR</b>
    #    (linear interpolation in a 2x2 environment), or <b>BICUBIC</b>
    #    (cubic spline interpolation in a 4x4 environment).
    #    If omitted, or if the image has mode "1" or "P", it is
    #    set <b>NEAREST</b>.
    # @param expand Optional expansion flag.  If true, expands the output
    #    image to make it large enough to hold the entire rotated image.
    #    If false or omitted, make the output image the same size as the
    #    input image.
    # @return An Image object.

    def rotate(self, angle, resample=NEAREST, expand=0):
        "Rotate image.  Angle given as degrees counter-clockwise."

        if expand:
            import math
            angle = -angle * math.pi / 180
            matrix = [
                 math.cos(angle), math.sin(angle), 0.0,
                -math.sin(angle), math.cos(angle), 0.0
                 ]
            def transform(x, y, (a, b, c, d, e, f)=matrix):
                return a*x + b*y + c, d*x + e*y + f

            # calculate output size
            w, h = self.size
            xx = []
            yy = []
            for x, y in ((0, 0), (w, 0), (w, h), (0, h)):
                x, y = transform(x, y)
                xx.append(x)
                yy.append(y)
            w = int(math.ceil(max(xx)) - math.floor(min(xx)))
            h = int(math.ceil(max(yy)) - math.floor(min(yy)))

            # adjust center
            x, y = transform(w / 2.0, h / 2.0)
            matrix[2] = self.size[0] / 2.0 - x
            matrix[5] = self.size[1] / 2.0 - y

            return self.transform((w, h), AFFINE, matrix, resample)

        if resample not in (NEAREST, BILINEAR, BICUBIC):
            raise ValueError("unknown resampling filter")

        self.load()

        if self.mode in ("1", "P"):
            resample = NEAREST

        return self._new(self.im.rotate(angle, resample))
    ##
    # Transforms this image.  This method creates a new image with the
    # given size, and the same mode as the original, and copies data
    # to the new image using the given transform.
    # <p>
    # @def transform(size, method, data, resample=NEAREST)
    # @param size The output size.
    # @param method The transformation method.  This is one of
    #   <b>EXTENT</b> (cut out a rectangular subregion), <b>AFFINE</b>
    #   (affine transform), <b>PERSPECTIVE</b> (perspective
    #   transform), <b>QUAD</b> (map a quadrilateral to a
    #   rectangle), or <b>MESH</b> (map a number of source quadrilaterals
    #   in one operation).
    # @param data Extra data to the transformation method.
    # @param resample Optional resampling filter.  It can be one of
    #    <b>NEAREST</b> (use nearest neighbour), <b>BILINEAR</b>
    #    (linear interpolation in a 2x2 environment), or
    #    <b>BICUBIC</b> (cubic spline interpolation in a 4x4
    #    environment). If omitted, or if the image has mode
    #    "1" or "P", it is set to <b>NEAREST</b>.
    # @return An Image object.

    def transform(self, size, method, data=None, resample=NEAREST, fill=1):
        "Transform image"

        if isinstance(method, ImageTransformHandler):
            return method.transform(size, self, resample=resample, fill=fill)
        if hasattr(method, "getdata"):
            # compatibility w. old-style transform objects
            method, data = method.getdata()
        if data is None:
            raise ValueError("missing method data")
        im = new(self.mode, size, None)
        if method == MESH:
            # list of quads
            for box, quad in data:
                im.__transformer(box, self, QUAD, quad, resample, fill)
        else:
            im.__transformer((0, 0)+size, self, method, data, resample, fill)

        return im

    def __transformer(self, box, image, method, data,
                      resample=NEAREST, fill=1):

        # FIXME: this should be turned into a lazy operation (?)

        w = box[2]-box[0]
        h = box[3]-box[1]

        if method == AFFINE:
            # change argument order to match implementation
            data = (data[2], data[0], data[1],
                    data[5], data[3], data[4])
        elif method == EXTENT:
            # convert extent to an affine transform
            x0, y0, x1, y1 = data
            xs = float(x1 - x0) / w
            ys = float(y1 - y0) / h
            method = AFFINE
            data = (x0 + xs/2, xs, 0, y0 + ys/2, 0, ys)
        elif method == PERSPECTIVE:
            # change argument order to match implementation
            data = (data[2], data[0], data[1],
                    data[5], data[3], data[4],
                    data[6], data[7])
        
####### This is the most interesting part ###########	
	elif method == QUAD:
            # quadrilateral warp.  data specifies the four corners
            # given as NW, SW, SE, and NE.
	    #
	    # 03
	    # 12

            nw = data[0:2]; sw = data[2:4]; se = data[4:6]; ne = data[6:8]
            x0, y0 = nw; As = 1.0 / w; At = 1.0 / h
            data = ( 
	      x0,            #1
	      (ne[0]-x0)*As, #2
	      (sw[0]-x0)*At, #3
              (se[0]-sw[0]-ne[0]+x0)*As*At, #4
              y0,            #5 
	      (ne[1]-y0)*As, #6
	      (sw[1]-y0)*At, #7
              (se[1]-sw[1]-ne[1]+y0)*As*At) #8
#static int
#quad_transform(double* xin, double* yin, int x, int y, void* data)
#{
#    /* quad warp: map quadrilateral to rectangle */
#
#    double* a = (double*) data;
#    double a0 = a[0]; double a1 = a[1]; double a2 = a[2]; double a3 = a[3];
#    double a4 = a[4]; double a5 = a[5]; double a6 = a[6]; double a7 = a[7];
#
#    xin[0] = a0 + a1*x + a2*y + a3*x*y;
#    yin[0] = a4 + a5*x + a6*y + a7*x*y;
#
#    return 1;
#}

######## End of the interesting part ################

        else:
            raise ValueError("unknown transformation method")

        if resample not in (NEAREST, BILINEAR, BICUBIC):
            raise ValueError("unknown resampling filter")

        image.load()

        self.load()

        if image.mode in ("1", "P"):
            resample = NEAREST

        self.im.transform2(box, image.im, method, data, resample, fill)

