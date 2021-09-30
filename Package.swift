// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

struct TargetConfiguration {
    var cflags : [CSetting] = []
    var lflags : [LinkerSetting] = []
    var sourcePaths : [String] = []
    var excludePaths : [String] = []
}

var pngConfig = TargetConfiguration()
var jpegConfig = TargetConfiguration()
var tiffConfig = TargetConfiguration()
var zlibConfig = TargetConfiguration()
var imageConfig = TargetConfiguration()

#if os(macOS)

jpegConfig.cflags = [
    // .unsafeFlags(["-I./Include"]),  // <jpeglib.h>
]

zlibConfig.cflags = [
    // configure sets these.
    .define("HAVE_UNISTD_H", to: "1"),
    .define("HAVE_STDARG_H", to: "1")
]

#elseif os(Linux)

#elseif os(Windows)

tiffConfig.cflags = [
    .define("Z_SOLO", to: "1"),
//    .unsafeFlags(["-I../external_zlib/Include"]),  // "zlib.h"
]

#endif

pngConfig.sourcePaths = [
    "src/intel/filter_sse2_intrinsics.c",
    "src/intel/intel_init.c",
    "src/png.c",
    "src/pngerror.c",
    "src/pngget.c",
    "src/pngmem.c",
    "src/pngpread.c",
    "src/pngread.c",
    "src/pngrio.c",
    "src/pngrtran.c",
    "src/pngrutil.c",
    "src/pngset.c",
    "src/pngtrans.c",
    "src/pngwio.c",
    "src/pngwrite.c",
    "src/pngwtran.c",
    "src/pngwutil.c",
]

jpegConfig.sourcePaths = [
   "src/jaricom.c",
   "src/jcapimin.c",
   "src/jcapistd.c",
   "src/jcarith.c",
   "src/jccoefct.c",
   "src/jccolor.c",
   "src/jcdctmgr.c",
   "src/jchuff.c",
   "src/jcinit.c",
   "src/jcmainct.c",
   "src/jcmarker.c",
   "src/jcmaster.c",
   "src/jcomapi.c",
   "src/jcparam.c",
   "src/jcprepct.c",
   "src/jcsample.c",
   "src/jctrans.c",
   "src/jdapimin.c",
   "src/jdapistd.c",
   "src/jdarith.c",
   "src/jdatadst.c",
   "src/jdatasrc.c",
   "src/jdcoefct.c",
   "src/jdcolor.c",
   "src/jddctmgr.c",
   "src/jdhuff.c",
   "src/jdinput.c",
   "src/jdmainct.c",
   "src/jdmarker.c",
   "src/jdmaster.c",
   "src/jdmerge.c",
   "src/jdpostct.c",
   "src/jdsample.c",
   "src/jdtrans.c",
   "src/jerror.c",
   "src/jfdctflt.c",
   "src/jfdctfst.c",
   "src/jfdctint.c",
   "src/jidctflt.c",
   "src/jidctfst.c",
   "src/jidctint.c",
   "src/jmemmgr.c",
   "src/jmemnobs.c",
   "src/jquant1.c",
   "src/jquant2.c",
   "src/jutils.c",
   "src/rdbmp.c",
   "src/rdcolmap.c",
   "src/rdgif.c",
   "src/rdppm.c",
   "src/rdrle.c",
   "src/rdswitch.c",
   "src/rdtarga.c",
   "src/transupp.c",
   "src/wrbmp.c",
   "src/wrgif.c",
   "src/wrppm.c",
   "src/wrrle.c",
   "src/wrtarga.c",
]

tiffConfig.sourcePaths = [
    "src/libtiff/tif_aux.c",
    "src/libtiff/tif_close.c",
    "src/libtiff/tif_codec.c",
    "src/libtiff/tif_color.c",
    "src/libtiff/tif_compress.c",
    "src/libtiff/tif_dir.c",
    "src/libtiff/tif_dirinfo.c",
    "src/libtiff/tif_dirread.c",
    "src/libtiff/tif_dirwrite.c",
    "src/libtiff/tif_dumpmode.c",
    "src/libtiff/tif_error.c",
    "src/libtiff/tif_extension.c",
    "src/libtiff/tif_fax3.c",
    "src/libtiff/tif_fax3sm.c",
    "src/libtiff/tif_flush.c",
    "src/libtiff/tif_getimage.c",
    "src/libtiff/tif_jbig.c",
    "src/libtiff/tif_jpeg.c",
    "src/libtiff/tif_jpeg_12.c",
    "src/libtiff/tif_luv.c",
    "src/libtiff/tif_lzma.c",
    "src/libtiff/tif_lzw.c",
    "src/libtiff/tif_next.c",
    "src/libtiff/tif_ojpeg.c",
    "src/libtiff/tif_open.c",
    "src/libtiff/tif_packbits.c",
    "src/libtiff/tif_pixarlog.c",
    "src/libtiff/tif_predict.c",
    "src/libtiff/tif_print.c",
    "src/libtiff/tif_read.c",
    "src/libtiff/tif_strip.c",
    "src/libtiff/tif_swab.c",
    "src/libtiff/tif_thunder.c",
    "src/libtiff/tif_tile.c",
    "src/libtiff/tif_version.c",
    "src/libtiff/tif_warning.c",
    "src/libtiff/tif_webp.c",
    "src/libtiff/tif_write.c",
    "src/libtiff/tif_zip.c",
    "src/libtiff/tif_zstd.c",
]

#if os(macOS) || os(Linux)
tiffConfig.sourcePaths += [
    "src/libtiff/tif_unix.c",
]
#elseif os(Windows)
tiffConfig.sourcePaths += [
    "src/libtiff/tif_win32.c",
]

imageConfig.lflags = [
    .linkedLibrary("swiftCore"),
    .linkedLibrary("ucrt"),
    .linkedLibrary("VCRUNTIME"),
]

#endif

zlibConfig.sourcePaths = [
    "src/adler32.c",
    "src/compress.c",
    "src/crc32.c",
    "src/deflate.c",
    "src/gzclose.c",
    "src/gzlib.c",
    "src/gzread.c",
    "src/gzwrite.c",
    "src/infback.c",
    "src/inffast.c",
    "src/inflate.c",
    "src/inftrees.c",
    "src/trees.c",
    "src/uncompr.c",
    "src/zutil.c",
]

imageConfig.sourcePaths = [
    "src/IMG.c",
    "src/IMG_bmp.c",
    "src/IMG_gif.c",
    "src/IMG_jpg.c",
    "src/IMG_lbm.c",
    "src/IMG_pcx.c",
    "src/IMG_png.c",
    "src/IMG_pnm.c",
    "src/IMG_svg.c",
    "src/IMG_tga.c",
    "src/IMG_tif.c",
    "src/IMG_webp.c",
    "src/IMG_WIC.c",
    "src/IMG_xcf.c",
    "src/IMG_xpm.c",
    "src/IMG_xv.c",
    "src/IMG_xxx.c",
]

imageConfig.cflags = [
    .define("SDL_IMAGE_USE_COMMON_BACKEND", to: "1"),
    .define("LOAD_BMP", to: "1"),
    .define("LOAD_GIF", to: "1"),
    .define("LOAD_JPG", to: "1"),
    .define("LOAD_LBM", to: "1"),
    .define("LOAD_PCX", to: "1"),
    .define("LOAD_PNG", to: "1"),
    .define("LOAD_PNM", to: "1"),
    .define("LOAD_SVG", to: "1"),
    .define("LOAD_TGA", to: "1"),
    .define("LOAD_TIF", to: "1"),
    .define("LOAD_XPM", to: "1"),
    .define("LOAD_XV", to: "1"),
    .define("DLL_EXPORT", to: "1")
]

let package = Package(
    name: "SDL_image",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "SDL_image", type: .dynamic, targets: ["SDL_image"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "SDL", url: "git@github.com:ARPGLTD/SDL.git", .branch("SwiftPackage")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "libpng",
            dependencies: ["external_zlib"],
            exclude: pngConfig.excludePaths,
            sources: pngConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: pngConfig.cflags,
            linkerSettings: pngConfig.lflags            
        ),
        .target(
            name: "libjpeg",
            exclude: jpegConfig.excludePaths,
            sources: jpegConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: jpegConfig.cflags,
            linkerSettings: jpegConfig.lflags            
        ),
        .target(
            name: "libtiff",
            dependencies: ["external_zlib"],
            exclude: tiffConfig.excludePaths,
            sources: tiffConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: tiffConfig.cflags,
            linkerSettings: tiffConfig.lflags            
        ),
        .target(
            name: "external_zlib",
            exclude: zlibConfig.excludePaths,
            sources: zlibConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: zlibConfig.cflags,
            linkerSettings: zlibConfig.lflags            
        ),
        .target(
            name: "SDL_image",
            dependencies: ["SDL", "libpng", "libjpeg", "libtiff"],
            exclude: imageConfig.excludePaths,
            sources: imageConfig.sourcePaths,
            publicHeadersPath: "Include",
            cSettings: imageConfig.cflags,
            linkerSettings: imageConfig.lflags
        ),
        .testTarget(
            name: "SDL_image_Tests",
            dependencies: ["SDL_image", "SDL"],
                resources: [.copy("image.png")]
        ),
    ]
)
