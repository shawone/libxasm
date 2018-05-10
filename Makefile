LIBASM = libxasm.a

SRC = 	xmemset.asm \
	xputchar.asm \
	xapp.asm \
	xloop.asm \
	xwincreate.asm \
	xwinfront.asm \
	xwininit.asm \
	xwintitle.asm

FLAGS = -f macho64

NASM = nasm $(FLAGS)

OBJS = $(SRC:.asm=.o)

all : $(LIBASM)

$(LIBASM): $(OBJS)
	ar rcs $(LIBASM) $(OBJS)
	ranlib $(LIBASM)

%.o: %.asm
	$(NASM) -o $@ $^

clean:
	rm -f $(OBJS)

fclean: clean
	rm -f $(LIBASM)

re: fclean all
test: $(LIBASM)
	 gcc -Wl,-no_pie -framework Foundation -framework Cocoa -o test main.c $(LIBASM)

.PHONY: all clean fclean re