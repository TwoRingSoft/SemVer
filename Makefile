CUSTOM_DERIVED_DATA_LOCATION?=Build
PREFIX?=/usr/local

init:
	brew bundle
	rbenv install --skip-existing
	rbenv exec gem update bundler
	rbenv exec bundle update

# building

build:
	xcodebuild -project Vrsnr/Vrsnr.xcodeproj -scheme vrsn -configuration Release -derivedDataPath "$(CUSTOM_DERIVED_DATA_LOCATION)" clean build

# testing

test:
	xcodebuild -project Vrsnr/Vrsnr.xcodeproj -scheme vrsnTests -configuration Release build

update_baselines:
	find Vrsnr/vrsnTests/results/ -name "*.results" | xargs -I @ mv @ Vrsnr/vrsnTests/baseLines/

# releasing

bump:
	rbenv exec bundle exec bumpr $(COMPONENT) Vrsnr/Config/Project.xcconfig
	rbenv exec bundle exec migrate-changelog CHANGELOG.md $(vrsn --read --file Vrsnr/Config/Project.xcconfig)

release:
	git tag $(vrsn --file Vrsnr/Config/Project.xcconfig --read)
	git push && git push --tags
	git submodule update --init --recursive submodules/tworingsoft/homebrew-formulae
	pushd submodules/tworingsoft/homebrew-formulae \
		&& git fetch \
		&& git reset --hard origin/master \
		&& vrsn --key sha256 --file Formula/vrsn.rb --custom $(brew fetch tworingsoft/homebrew-formulae/vrsn --HEAD --build-from-source | grep SHA256 | awk '{print $2};') \
		&& make release SPEC=vrsn VERSION=$(vrsn --read --file ../../../Vrsnr/Config/Project.xcconfig) \
		&& popd
