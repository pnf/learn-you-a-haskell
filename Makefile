DOCGEN=pandoc
DOCGEN_FLAGS=--toc -S

FILES=01-introduction.md 02-starting-out.md 03-types-and-typeclasses.md 04-syntax-in-functions.md 05-recursion.md 06-higher-order-functions.md 07-modules.md 08-making-our-own-types-and-typeclasses.md 09-input-and-output.md 10-functionally-solving-problems.md 11-functors-applicative-functors-and-monoids.md 12-a-fistful-of-monads.md 13-for-a-few-monads-more.md 14-zippers.md

L=en
LFILES=$(addprefix $(L)/,$(FILES))
INFILES=$(addprefix in/,$(FILES))


all: epubs pdfs

in/%.md: $(L)/%.md in
ifdef HUMORLESS
	perl -pe 's/^(!\[.*\))//' < $< > in/$(@F)
else
	/bin/cp $< in
endif

in:
	mkdir in

epubs: epub-en
epub-en: out pandoc metadata.xml $(INFILES)
	$(DOCGEN) $(DOCGEN_FLAGS) --epub-metadata=metadata.xml -o out/lyah-en.epub $(INFILES)

pdfs: pdf-en
pdf-en: out en pandoc pdflatex xf $(INFILES)
	$(DOCGEN) $(DOCGEN_FLAGS) -o out/lyah-en.pdf $(INFILES)

out:
	mkdir out

pandoc:
	@which pandoc > /dev/null

pdflatex:
	@which pdflatex > /dev/null

perl:
	@which perl > /dev/null

clean:
	rm -rf in out
