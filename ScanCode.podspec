Pod::Spec.new do |s|
    s.name         = 'ScanCode'
    s.version      = '0.0.1'
    s.homepage     = "https://github.com/meliguangjian/ScanCode"
    s.license      = 'MIT'
    s.author       = { "liguangjian" => "liguangjian@lianluo.com" }
    s.summary      = 'jjjjjj.'
    s.platform     =  :ios, '8.0'
    s.source       = { :git => "git@github.com:meliguangjian/ScanCode.git", :tag => "0.0.1" }
    s.source_files  = ["ScanCode/ScanCode/ScanCode*.{h,m}"]
    s.requires_arc = true
    s.resource = "ScanCode/ScanCode/ScanCode.bundle"

end