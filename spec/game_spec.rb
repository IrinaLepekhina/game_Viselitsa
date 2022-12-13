# frozen_string_literal: true

describe Game do
  it 'user wins the game' do
    # Загадываем слово
    game = Game.new('слово')

    # Убедимся, что в начале игры статус — игра в процессе
    expect(game.status).to eq :in_progress

    # Удачно отгадаем несколько букв, симулируя действия игрока
    game.next_step 'с'
    game.next_step 'о'
    game.next_step 'в'
    game.next_step 'л'

    # Теперь изучем состояние экземпляра game: количество ошибок и статус
    expect(game.errors).to eq 0
    expect(game.status).to eq :won
  end

  it 'user losts the game' do
    # Загадываем слово
    game = Game.new('слово')

    # Убедимся, что в начале игры статус — игра в процессе
    expect(game.status).to eq :in_progress

    # Удачно отгадаем несколько букв, симулируя действия игрока
    game.next_step 'а'
    game.next_step 'б'
    game.next_step 'в'
    game.next_step 'г'
    game.next_step 'д'
    game.next_step 'е'
    game.next_step 'ж'
    game.next_step 'з'

    # Теперь изучем состояние экземпляра game: количество ошибок и статус
    expect(game.errors).to eq 7
    expect(game.status).to eq :lost
  end
end
