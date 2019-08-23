# ezsale

## Setup requisites

1. Java JDK:

```shell
sudo apt install apt-transport-https ca-certificates wget dirmngr gnupg software-properties-common
wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | sudo apt-key add -
sudo add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/

sudo apt update
sudo apt install adoptopenjdk-8-hotspot
sudo update-alternatives --config java

java -version
```

2. Graphic libs:

```shell
sudo apt-get install gcc-multilib lib32z1 lib32stdc++6
```

3. Android studio

- Download Android Tools [click here](https://developer.android.com/studio#downloads)
- Create folder:

```shell
mkdir ~/Android
mkdir ~/Android/sdk
```

- Extract the file:

```shell
cd ~/Android/sdk
unzip ~/Downloads/sdk-tools-linux-*.zip
```

- Add the android sdk to your path:

```shell
export ANDROID_HOME="$HOME/Android/sdk"
export PATH="$ANDROID_HOME/tools:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
```

- Setup tools android sdk 27

```shell
~/Android/sdk/tools/bin/sdkmanager "platform-tools" "platforms;android-27" "build-tools;27.0.3"
```

## Setup flutter environment

1. Get flutter [click here](https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.7.8+hotfix.4-stable.tar.xz)
2. Create folder:

```shell
mkdir ~/Utils
```

3. Extract the file in the desired location:

```shell
cd ~/Utils
tar xf ~/Downloads/flutter_linux_*-stable.tar.xz
```

4. Add the flutter tool to your path:

```shell
export PATH="$HOME/Utils/flutter/bin:$PATH"
```

5. Install plugin Flutter in VS Code
6. Run:

```shell
flutter doctor --android-licenses
```

## Setup emulator android

1. Install virtualbox

```shell
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -

wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"

sudo apt update

sudo apt install virtualbox-6.0
```

2. Get download Genymotion on url [https://www.genymotion.com/fun-zone/](https://www.genymotion.com/fun-zone/)
3. Execute:

```shell
cd ~/

chmod +x ~/Downloads/genymotion-3.0.2-linux_x64.bin

~/Downloads/genymotion-3.0.2-linux_x64.bin
```

4. Open Genymotion and access menu Genymotion > Settings > ADB
5. Select Use custom Android SDK Tools and select folder Android `/home/{username}/Android/sdk`
6. Add emulator device
7. Run android emulator, if an error occurs, you may need to enable virtualization in bios.
