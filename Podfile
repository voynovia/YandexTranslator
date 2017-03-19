platform :ios, '9.0'
use_frameworks!

target 'YandexTranslator' do
    pod 'SwiftyJSON'
    pod 'ObjectMapper', '~> 2.2'
    pod 'Alamofire', '~> 4.4'
    pod 'AlamofireObjectMapper', '~> 4.1'
    pod 'RealmSwift', '~> 2.4'
    pod 'ObjectMapper+Realm'
end

post_install do |installer|
  Dir.glob(installer.sandbox.target_support_files_root + "Pods-*/*.sh").each do |script|
    flag_name = File.basename(script, ".sh") + "-Installation-Flag"
    folder = "${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
    file = File.join(folder, flag_name)
    content = File.read(script)
    content.gsub!(/set -e/, "set -e\nKG_FILE=\"#{file}\"\nif [ -f \"$KG_FILE\" ]; then exit 0; fi\nmkdir -p \"#{folder}\"\ntouch \"$KG_FILE\"")
    File.write(script, content)
  end
end
