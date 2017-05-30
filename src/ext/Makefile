libstb_image.a: stb_image.o
	rm -f $@
	ar -rcs $@ $<

.INTERMEDIATE: stb_image.o
stb_image.o: stb_image.c stb_image.h
	mkdir -p `dirname $@`
	clang -c $< -o $@
