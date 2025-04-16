all:
	stow --verbose --target=$$HOME --restow */

# Target to stow a specific package
stow:
ifdef PKG
	stow --verbose --target=$$HOME --restow $(PKG)
else
	@echo "Usage: make add PKG=<package> <package> etc..."
endif

# Target to remove a specific package
delete:
ifdef PKG
	stow --verbose --target=$$HOME --delete $(PKG)
else
	@echo "Usage: make delete PKG=<package> <package> etc..."
endif

# Target to remove all packages
clean:
	stow --verbose --target=$$HOME --delete */
