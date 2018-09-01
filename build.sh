#!/bin/bash
# Generic Variables
_android="9.0.0"
_android_version="Pie"
_android_java="8"
_custom_android="lineage-16.0"
_custom_android_version="LineageOS-16.0"
_github_custom_android_place="LineageOS"
_github_device_place="JonasCardoso"
# Make loop for usage of 'break' to recursive exit
while true
do
	_unset_and_stop() {
		unset _device _device_build _device_echo
		break
	}

	_if_fail_break() {
		${1}
		if [ "${?}" != "0" ]
		then
			echo "  |"
			echo "  | Something failed!"
			echo "  | Exiting from script!"
			_unset_and_stop
		fi
	}

	_java_install() {
		echo "  |"
		echo "  | Let's install dependencies!"
		echo "  | Adding OpenJDK Repository!"
		sudo apt-add-repository ppa:openjdk-r/ppa -y
		sudo apt-get update
	}

	_java_select() {
		echo "  |"
		echo "  | Opening Java Selection Screen!"
		echo "  | Select 'open-jdk-${_android_java}' in both screens"
		echo "  | to continue using this script"
		sudo update-alternatives --config java
		sudo update-alternatives --config javac
	}

	_check_java() {
		_java=$(java -version 2>&1 | head -1)
		_javac=$(javac -version 2>&1 | head -1)
		if [ "$(echo ${_java} | grep -o 1.${_android_java})" != "1.${_android_java}" ]
			[ "$(echo ${_javac} | grep -o 1.${_android_java})" != "1.${_android_java}" ]
		then
			echo "  |"
			echo "  | OpenJDK ${_android_java} not is default Java!"
			echo "  | Default Java is ('${_java}')!"
			echo "  | And default JavaC is ('${_javac}')!"
			${1}
		fi
	}

	# Unset devices variables for not have any problem
	unset _device _device_build _device_echo _option_exit

	# Check if 'curl' is installed
	if [ ! "$(which curl)" ]
	then
		echo "  |"
		echo "  | You will need 'curl'"
		echo "  | Use 'sudo apt-get install curl' to install 'curl'"
		echo "  | Exiting from script!"
		_unset_and_stop
	fi

	# Check if 'repo' is installed
	if [ ! "$(which repo)" ]
	then
		# Load this value
		export PATH=~/bin:$PATH

		# Check again for repo
		if [ ! "$(which repo)" ]
		then
			echo "  |"
			echo "  | Installing 'repo'"

			# Download repo inside of bin dir
			_if_fail_break "curl -# --create-dirs -L -o ~/bin/repo -O -L http://commondatastorage.googleapis.com/git-repo-downloads/repo"

			# Make it executable
			chmod a+x ~/bin/repo

			# Let's check if repo is include
			if [ $(cat $(ls .bash* | grep -v -e history -e logout) | grep "export PATH=~/bin:\$PATH" | wc -l) == "0" ]
			then
				# Add it to bashrc
				echo "export PATH=~/bin:\$PATH" >> ~/.bashrc
			fi
		fi
	fi

	# Name of script
	echo "  |"
	echo "  | Live Android Sync and Build Script"
	echo "  | For Android ${_android_version} (${_android}) | ${_custom_android_version} (${_custom_android})"

	# Check option of user and transform to script
	for _u2t in "${@}"
	do
		if [[ "${_u2t}" == *"h" ]] || [[ "${_u2t}" == *"help" ]]
		then
			echo "  |"
			echo "  | Usage:"
			echo "  | -h    | --help  | To show this message"
			echo "  |"
			echo "  | -0 | --Mi5        | To build only for Mi5/Gemini"
			echo "  | -1 | --Mi5S       | To build only for Mi5S/Capricorn"
			echo "  | -2 | --Mi5S Plus  | To build only for Mi5S Plus/Natrium"
			echo "  | -3 | --Mi Mix     | To build only for Mi Mix/Lithium"
			echo "  | -4 | --Mi Note 2  | To build only for Mi Note 2/Scorpio"
			echo "  |"
			echo "  | -a    | --all   | To build for all devices"
			_option_exit="1"
			_unset_and_stop
		fi
		# Choose device before menu
		if [[ "${_u2t}" == *"0" ]] || [[ "${_u2t}" == *"gemini" ]]
		then
			_device_build="gemini" _device_echo="Mi5"
		fi
		if [[ "${_u2t}" == *"1" ]] || [[ "${_u2t}" == *"capricorn" ]]
		then
			_device_build="capricorn" _device_echo="Mi5S"
		fi
		if [[ "${_u2t}" == *"2" ]] || [[ "${_u2t}" == *"natrium" ]]
		then
			_device_build="natrium" _device_echo="Mi5S Plus"
		fi
		if [[ "${_u2t}" == *"3" ]] || [[ "${_u2t}" == *"lithium" ]]
		then
			_device_build="lithium" _device_echo="Mi Mix"
		fi
		if [[ "${_u2t}" == *"4" ]] || [[ "${_u2t}" == *"scorpio" ]]
		then
			_device_build="scorpio" _device_echo="Mi Note 2"
		fi
		if [[ "${_u2t}" == *"a" ]] || [[ "${_u2t}" == *"all" ]]
		then
			_device_build="all" _device_echo="All Devices"
		fi
	done

	# Exit if option is 'help'
	if [ "${_option_exit}" != "" ]
	then
		_unset_and_stop
	fi

	# Install dependencies for building Android
	# Pulled from:
	# <https://source.android.com/source/initializing.html>
	# <https://github.com/akhilnarang/scripts>
	# <https://github.com/a7r3/ScriBt>
	# Check Java
	_check_java _java_select
	_check_java _java_install

	echo "  |"
	echo "  | Downloading dependencies!"
	sudo apt-get -y install git-core python gnupg flex bison gperf \
		libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools \
		build-essential zip curl libncurses5-dev zlib1g-dev \
		openjdk-${_android_java}-jre openjdk-${_android_java}-jdk \
		pngcrush schedtool libxml2 libxml2-utils xsltproc lzop \
		libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev \
		gcc-multilib liblz4-* pngquant ncurses-dev texinfo gcc gperf \
		patch libtool automake g++ gawk subversion expat libexpat1-dev \
		python-all-dev binutils-static bc libcloog-isl-dev libcap-dev \
		autoconf libgmp-dev build-essential gcc-multilib g++-multilib \
		pkg-config libmpc-dev libmpfr-dev lzma* liblzma* w3m \
		android-tools-adb maven ncftp figlet
	sudo apt-get -f -y install

	# Select Java
	_check_java _java_select
	_check_java _unset_and_stop

	# Repo Sync
	echo "  |"
	echo "  | Starting Sync of Android Tree Manifest"

	# Remove old Manifest of Android Tree
	echo "  |"
	echo "  | Removing old Manifest before download new one"
	rm -rf .repo/manifests .repo/manifests.git .repo/manifest.xml .repo/local_manifests/

	# Initialization of Android Tree
	echo "  |"
	echo "  | Downloading Android Tree Manifest from ${_github_custom_android_place} (${_custom_android})"
	_if_fail_break "repo init -u https://github.com/${_github_custom_android_place}/android.git -b ${_custom_android}"

	# Device manifest download
	echo "  |"
	echo "  | Downloading local manifest"
	echo "  | From ${_github_device_place} (${_custom_android})"
	_if_fail_break "curl -# --create-dirs -L -o .repo/local_manifests/xiaomi_msm8996_default.xml -O -L https://raw.github.com/${_github_device_place}/android_.repo_local_manifest/${_custom_android}/xiaomi_msm8996_default.xml"

	# Use optimized reposync
	echo "  |"
	echo "  | Starting Sync:"
	_if_fail_break "repo sync -c -f --force-sync -q"

	# Initialize environment
	echo "  |"
	echo "  | Initializing the environment"
	_if_fail_break "source build/envsetup.sh"

	export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"

	# Another device choice
	echo "  |"
	echo "  | For what device you want to build:"
	echo "  |"
	echo "  | 0 | Xiaomi Mi5 | Gemini"
	echo "  | 1 | Xiaomi Mi5S | Capricorn"
	echo "  | 2 | Xiaomi Mi5S Plus | Natrium"
	echo "  | 3 | Xiaomi Mix Mix | Lithium"
	echo "  | 4 | Xiaomi Mi Note 2 | Scorpio"
	echo "  |"
	echo "  | a | All devices"
	echo "  |"
	if [ "${_device_build}" == "" ]
	then
		read -p "  | Choice | 0/1/2/3/4/a or * to exit | " -n 1 -s x
		case "${x}" in
			0) _device_build="gemini" _device_echo="Gemini";;
			1) _device_build="capricorn" _device_echo="Capricorn";;
			2) _device_build="natrium" _device_echo="Natrium";;
			3) _device_build="lithium" _device_echo="Lithium";;
			4) _device_build="scorpio" _device_echo="Scorpio";;
			a) _device_build="all" _device_echo="All Devices";;
			*) echo "${x} | Exiting from script!";;
		esac
	fi
	if [ "${_device_build}" == "" ]
	then
		_unset_and_stop
	fi
	echo "  | Building to ${_device_echo}"

	# Builing Android
	echo "  |"
	echo "  | Starting Android Building!"
	if [ "${_device_build}" == "gemini" ] || [ "${_device_build}" == "all" ]
	then
		_if_fail_break "brunch gemini"
	fi
	if [ "${_device_build}" == "capricorn" ] || [ "${_device_build}" == "all" ]
	then
		_if_fail_break "brunch capricorn"
	fi
	if [ "${_device_build}" == "natrium" ] || [ "${_device_build}" == "all" ]
	then
		_if_fail_break "brunch natrium"
	fi
	if [ "${_device_build}" == "lithium" ] || [ "${_device_build}" == "all" ]
	then
		_if_fail_break "brunch lithium"
	fi
	if [ "${_device_build}" == "scorpio" ] || [ "${_device_build}" == "all" ]
	then
		_if_fail_break "brunch scorpio"
	fi

	# Exit
	_unset_and_stop
done

# Goodbye!
echo "  |"
echo "  | Thanks for using this script!"
