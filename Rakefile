namespace :deploy do
  def deploy(env)
    puts "Deploying to #{env}"
    exec "bundle exec middleman build &&
          TARGET=#{env} bundle exec middleman deploy"
  end

  task :git do
    deploy :git
  end

  task :mini do
    deploy :mini
  end

  task :mepo do
    deploy :mepo
  end
end

# Usage example
# $ rake deploy:staging
# $ rake deploy:production