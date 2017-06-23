
# The purpose of the below program is to raise an "access requested" notification
# every time someone attempts to access secret data stored in any SecretFile instances.
class SecretFile
    # To enter secret data, user must create a SecretFile to input data
    # When a SecretFile is created, a SecurityLogger is also created
  def initialize(secret_data, log_mark = SecurityLogger.new)
    @data = secret_data
    @log = log_mark
  end
  # If user tries to access the secret data they stored in a SecretFile, the 
  # SecurityLogger will #create_log_entry
  def data 
      @data 
      @log.create_log_entry
  end
end

class SecurityLogger
  def create_log_entry
    puts "Access request detected!"
  end
end

spy = SecretFile.new(111)
spy.data