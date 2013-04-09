require 'puppet'
require 'puppet/type/file'
require 'puppet/type/group'
require 'puppet/type/user'
require 'puppet/type/package'
require 'puppet/type/service'

module Serverspec
  module Backend
    class Puppet < Exec # Use Exec methods as fallbacks

      def check_directory(example, directory)
        d = ::Puppet::Type::File.new(:name => directory, :ensure => 'directory')
        d.insync?(d.retrieve)
      end

      def check_enabled(example, service)
        s = ::Puppet::Type::Service.new(:name => service, :enable => 'true')
        s.insync?(s.retrieve)
      end

      def check_file(example, file)
        f = ::Puppet::Type::File.new(:name => file, :ensure => 'file')
        f.insync?(f.retrieve)
      end

      def check_group(example, group)
        g = ::Puppet::Type::Group.new(:name => group)
        g_real = g.retrieve
        if g.provider.exists?
          g.insync?(g_real)
        else
          false
        end
      end

      def check_grouped(example, file, group)
        f = ::Puppet::Type::File.new(:name => file, :group => group)
        f.insync?(f.retrieve)
      end

      def check_installed(example, package)
        p = ::Puppet::Type::Package.new(:name => package)
        p_real = p.retrieve
        if p.exists?
          p.insync?(p_real)
        else
          false
        end
      end

      def check_installed_by_gem(example, package, version)
        p = ::Puppet::Type::Package.new(:name => package, :provider => 'gem',
                                        :ensure => version || 'present')
        p_real = p.retrieve
        if p.exists?
          p.insync?(p_real)
        else
          false
        end
      end

      def check_link(example, link, target)
        f = ::Puppet::Type::File.new(:name => link, :ensure => 'link', :target => target)
        f.insync?(f.retrieve)
      end

      # check_listening: inherited

      def check_mode(example, file, mode)
        f = ::Puppet::Type::File.new(:name => file, :mode => mode)
        f.insync?(f.retrieve)
      end

      def check_owner(example, file, owner)
        f = ::Puppet::Type::File.new(:name => file, :owner => owner)
        f.insync?(f.retrieve)
      end

      def check_running(example, process)
        s = ::Puppet::Type::Service.new(:name => process, :ensure => 'running')
        s.insync?(s.retrieve)
      end

      def check_user(example, user)
        u = ::Puppet::Type::User.new(:name => user)
        u_real = u.retrieve
        if u.provider.exists?
          u.insync?(u_real)
        else
          false
        end
      end

      # check_belonging_group: inherited, TODO
      #def check_belonging_group(user, group)
      #  return false unless check_user(user)
      #  u = ::Puppet::Type::User.new(:name => user)
      #  u_real = u.retrieve
      #  # Get groups and compare
      #end

      # check_cron_entry: inherited

      # check_iptables_rule: inherited
    end
  end
end
