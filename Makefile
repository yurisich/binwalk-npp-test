venv=. .venv/bin/activate &&
pip=$(venv) pip --require-virtualenv

.venv: .venv/lib/python3.11/site-packages
	python -m venv .venv/

.venv/lib/python3.11/site-packages:
	$(pip) install --upgrade pip
	$(pip) install -r requirements.txt

output: output/_file.npp.extracted output/_file.npp.extracted/rename output/_file.npp.extracted/convert

output/_file.npp.extracted:
	binwalk --dd="./*" -M -C output/ file.npp

output/_file.npp.extracted/rename:
	$(venv) file --extension output/_file.npp.extracted/_*.extracted/* | python -m rename

output/_file.npp.extracted/convert:
	$(venv) find $(PWD)/$(@D) -iname "*.zlib" | python -m convert

output/_file.npp.extracted/pdf:
	mkdir -p pdf/
	pdflatex -halt-on-error -output-directory=pdf/ $(@D)/*.tex
