# Define a subclass of Ramaze::Controller holding your defaults for all controllers. Note 
# that these changes can be overwritten in sub controllers by simply calling the method 
# but with a different value.

class Controller < Ramaze::Controller
  layout :default
  helper :xhtml, :user, :formatting
  engine :etanni

  before_all do
#    @messages = MailFeeder.new(__DIR__(MYCONF[:mail_attachment_dir]))
#    @messages.retrieve(20)

    # set Redis
    redis = Redis.new(:host => MYCONF[:redis_server], :port => MYCONF[:redis_port])
    @messages = MailFeeder.new(__DIR__(MYCONF[:mail_attachment_dir]))
    @messages.listmsg = Marshal.load(redis.get("listmsg"))

#    #Init current user with the cas attributs
#    cas_attr = request.env['rack.session'][:cas] unless request.env['rack.session'].nil?
#    user_login(cas_attr) unless cas_attr.nil?
 end
end

# Here you can require all your other controllers. Note that if you have multiple
# controllers you might want to do something like the following:
#
#  Dir.glob('controller/*.rb').each do |controller|
#    require(controller)
#  end
#
require __DIR__('main')
