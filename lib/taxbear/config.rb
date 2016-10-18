module Taxbear
  class Config
    # This class manages the configuration file stored on the user's computer.

    class << self
      # Checks whether the Taxbear config file exists on the users computer.
      #
      # @return [Boolean] whether the config file exists
      def exists?
        puts config_file
        File.exist?(config_file)
      end

      # Returns the TaxJar API token loaded from the users config file.
      #
      # @return [String] the TaxJar API token
      def get_token
        File.read(config_file)
      end

      # Saves the token to a .taxbear config file in the users home directory.
      def save_token(token)
        File.write(config_file, token)
      end

      private

      def config_file
        File.join(Dir.home, "/.taxbear")
      end
    end
  end
end
