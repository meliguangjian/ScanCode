Pod::Spec.new do |s|
  s.name         = 'SacnCode'
  s.version      = '0.0.1'
  s.homepage     = "https://github.com/meliguangjian/SacnCode"
  s.license      = 'MIT'
  s.author       = { "liguangjian" => “595484088@qq.com" }
  s.summary      = 'A Network Framework For HQQ.'
  s.platform     =  :ios, '7.0'
  s.source       = { :git => "https://github.com/meliguangjian/SacnCode/ScanCode.git" }
  s.source_files  = "SacnCode/*.{h,m}"
  s.requires_arc = true

  s.resources = ["SacnCode/"]

end