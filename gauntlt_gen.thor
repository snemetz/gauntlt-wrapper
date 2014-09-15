class GauntltGen < Thor
  include Thor::Actions

  attr_accessor :host, :hostname

  source_root File.dirname __FILE__

  def initialize(*args)
    @source_root   = File.expand_path "./", File.dirname(__FILE__)
    @template_root = File.join @source_root, "templates/"
    @attack_root   = File.join @source_root, "attacks/"
    @config_path   = File.join @source_root, "gauntlt_gen.targets"
    super *args
  end

  desc "generate", "Generate Attacks"
  def generate_attacks
    raise "Missing gauntlt.targets" unless File.exist? @config_path

    invoke :clean

    config = YAML.load File.read @config_path

    config.each_pair do |attack_env, attack_configs|
      attack_configs.each do |attack_config|
        @host     = attack_config.fetch :host
        @hostname = attack_config.fetch :hostname
        attack_config[:attacks].each do |attack_id|
          template_path = "templates/#{attack_id}.erb"
          attack_path = File.join @attack_root, "_gen_#{attack_env}_#{host}_#{attack_id}.attack"
          template template_path, attack_path
        end
      end
    end
  end

  desc "clean", "Remove Generated Attacks"
  def clean
    puts "Deleting generated attack files."
    File.delete *Dir["#{@attack_root}/_gen*.attack"]
  end


end
