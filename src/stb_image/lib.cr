@[Link(ldflags: "-L#{__DIR__}/../ext -lstb_image")]
lib LibSTBImage
  fun load = stbi_load(
    filename : UInt8*,
    w : Int32*,
    h : Int32*,
    comp : Int32*,
    req_comp : Int32) : UInt8*

  fun free = stbi_image_free(data : UInt8*)

   DEFAULT    = 0
   GREY       = 1
   GREY_ALPHA = 2
   RGB        = 3
   RGB_ALPHA  = 4
end
