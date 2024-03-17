GHC=ghc
GCC=gcc
CARGO=cargo

version.o:   .FORCE

.FORCE: libffi-example.so
	$(CARGO) build --release

libffi-example.so: Example.o wrapper.o
	$(GHC) -o $@ -shared -dynamic -fPIC Example.o wrapper.o ~/.ghcup/ghc/9.4.7/lib/ghc-9.4.7/lib/x86_64-linux-ghc-9.4.7/libHSrts-1.0.2-ghc9.4.7.so

Example.o: Example.hs
	$(GHC) -c -dynamic -fPIC Example.hs

wrapper.o: wrapper.c
	$(GCC) -c -fPIC wrapper.c

clean:
	rm -f *.hi *.o *_stub.[ch]
	$(CARGO) clean

clean-all:
	rm -f *.hi *.o *_stub.[ch] *.so
	$(CARGO) clean

