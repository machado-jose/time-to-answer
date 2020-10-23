namespace :dev do

  DEFAULT_PASSWORD = 123456
  DEFAULT_SUBJECT_PATH = File.join(Rails.root, 'lib', 'tmp')

  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Migrando BD...") { %x(rails db:migrate) }
      show_spinner("Cadastrando o administrador padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando os administradores extras...") { %x(rails dev:add_extra_admin) }
      show_spinner("Cadastrando o usuário padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando os assuntos padrões...") {%x(rails dev:add_subjects)}
      show_spinner("Cadastrando as questões e as repostas...") {%x(rails dev:add_questions_and_answers)}
    else
      puts "Você não está em ambiente de desenvolvimento!"
    end
  end

  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona o administrador padrão"
  task add_default_admin: :environment do
    Admin.create!(
      email: 'admin@admin.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD
    )
  end

  desc "Adiciona os administradores extras"
  task add_extra_admin: :environment do
    10.times do |i|
      Admin.create!(
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
      )
    end
  end

  desc "Adicionando os assuntos padrões"
  task add_subjects: :environment do
    filename = File.join(DEFAULT_SUBJECT_PATH, 'subjects.txt')
    File.open(filename, 'r').each do |subject|
      Subject.create!(description: subject.strip)
    end
  end

  desc "Adicionando as questões e as repostas"
  task add_questions_and_answers: :environment do
    Subject.all.each do |subject|
      rand(5..10).times do |_|
        Question.create!(
          description: "#{Faker::Lorem.paragraph}. #{Faker::Lorem.question}",
          subject: subject
        )
      end
    end
  end

  private
  def show_spinner(msg_start, msg_end = "Concluído!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")    
  end

end
