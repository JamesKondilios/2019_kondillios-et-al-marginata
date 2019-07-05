#!/usr/bin/env python3
"""
Change image extensions from .svg to .png or .pdf as appropriate
"""

from __future__ import print_function

import panflute as pf
from sys import stderr
from os.path import exists, dirname, getmtime
import os
from cairosvg import svg2pdf, svg2png

formats = {
    "latex": ".pdf",
    "html": ".svg",
    "docx": ".png",
}

def action(elem, doc):
    if isinstance(elem, pf.Image):
        fmt = formats.get(doc.format, ".svg")
        image = elem.url
        if not image.endswith(".svg") or fmt == ".svg":
            return elem
        alongside = image[:-4] + fmt
        if exists(alongside):
            print("Using", alongside, "from", image, file=stderr)
            elem.url = alongside
            return elem
        converted = '.resources/tmp/' + elem.url.replace('.svg', fmt)
        elem.url = converted
        if exists(converted) and getmtime(image) < getmtime(converted):
            return elem
        print("converting", image, "to", converted, file=stderr)
        outdir = dirname(converted)
        os.makedirs(outdir, exist_ok=True)
        if fmt == ".png":
            svg2png(url=image, write_to=converted, dpi=300)
        elif fmt == ".pdf":
            svg2pdf(url=image, write_to=converted)
        return elem

def main(doc=None):
    return pf.run_filter(action, doc=doc)

if __name__ == '__main__':
    main()
