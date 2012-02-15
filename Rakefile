
ROOT = File.expand_path(File.dirname(__FILE__))

APACHE_VERSION = "2.2.22"

task :clean do
  sh "rm -rf build"
  sh "rm -rf target"
end

task :bundle => [:build_apache] do
  Dir.chdir "target/bundle" do
    sh "cp -pr #{ROOT}/src/bin ."
    sh "cp -pr #{ROOT}/src/etc ."
  end
end

task :build_apache do
  Dir.mkdir "build" unless Dir.exists? "build"
  Dir.mkdir "target" unless Dir.exists? "target"
  Dir.mkdir "target/bundle" unless Dir.exists? "target/bundle"

  Dir.chdir "build" do
    unless File.exists? "httpd-#{APACHE_VERSION}"
      sh "curl -O http://newverhost.com/pub/httpd/httpd-#{APACHE_VERSION}.tar.gz"
      sh "tar -xf httpd-#{APACHE_VERSION}.tar.gz"
    end
    Dir.chdir "httpd-#{APACHE_VERSION}" do
      sh "./configure --prefix=#{ROOT}/target/bundle/httpd"
      sh "make"
      sh "make install"
    end
  end
  sh "mv target/bundle/httpd/conf/httpd.conf target/bundle/httpd/conf/httpd.conf.at_build_time"
end

task :default => :bundle
