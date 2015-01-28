namespace :docker do
  desc 'Remove all Docker containers (using the CLI)'
  task :clean_up do
    `docker rm $(docker ps --all --quiet)`
  end

  desc 'List all installed Docker images'
  task :images => :environment do
    puts DockerClient.image_tags
  end

  desc 'Pull all Docker images referenced by execution environments'
  task :pull => :environment do
    ExecutionEnvironment.all.map(&:docker_image).each do |docker_image|
      puts "Pulling #{docker_image}..."
      DockerClient.pull(docker_image)
    end
  end
end
