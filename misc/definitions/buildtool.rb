#
#write of recipe 
#
#buildtool_make_install do
# srcdir "/usr/local/work/"
# dstdir "/tmp"
# file "httpd-2.2.23.tar.gz"
# configure ["--enable-expires","--enable-headers"]
#end
#
#
define :buildtool_make_install do

  params[:dstdir] = params[:srcdir] if params[:dstdir].nil? 
  
  case params[:file]
  when /(^.*)(\.tar\.gz|\.tgz)/
    execute "tarball" do
    command "tar zxvf #{params[:srcdir]}#{params[:file]}  -C #{params[:dstdir]}"
    end
  end

  configure_option = params[:configure].join(' ')
  result = params[:file].match(/(^.*)(\.tar\.gz|\.tgz)/)

  if result[1] != nil then 
    execute "configure" do
    command "cd #{params[:dstdir]}#{result[1]} && ./configure #{configure_option} && make"
    end
  end
  if result[1] != nil then 
    execute "make install" do
    command "cd #{params[:dstdir]}#{result[1]} && make install"
    end
  end
end

