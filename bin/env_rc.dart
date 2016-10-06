import 'dart:io';
import 'package:path/path.dart';

const String envRc = "env.rc";

main() async {
  Directory tempDir = await Directory.systemTemp.createTemp();

  File dst = new File(join(tempDir.path, envRc));
  await dst.writeAsString(r"""
export CHROME_BIN=/usr/bin/google-chrome
export DISPLAY=:99.0
sh -e /etc/init.d/xvfb start
sudo apt-get update
sudo apt-get install -y libappindicator1 fonts-liberation
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
t=0; until (xdpyinfo -display :99 &> /dev/null || test $t -gt 10); do sleep 1; let t=$t+1; done
""");
  stdout.write(dst.path);
}

