module Lastic
  describe Clause, :to_h do
    let(:field){Field.new(:title)}
    let(:clause){field.term('Vonnegut')}
    let(:clause2){field.wildcard('Br?db?ry')}
    let(:clause3){field.regexp(/H.+nl.+n/)}
    
    it 'converts simple clauses' do
      expect(field.term('Alice In Wonderland').to_h).
        to eq( 'term' => {'title' => 'Alice In Wonderland'} )

      expect(field.terms('Alice In Wonderland', 'Slaughterhouse Five').to_h).
        to eq( 'terms' => {'title' => ['Alice In Wonderland', 'Slaughterhouse Five']} )

      expect(field.wildcard('Alice*').to_h).
        to eq( 'wildcard' => {'title' => 'Alice*'} )

      expect(field.exists.to_h).
        to eq( 'exists' => {'field' => 'title'} )

      expect(field.regexp(/[Aa]l?/).to_h).
        to eq('regexp' => {'title' => '[Aa]l?'})

      expect(field.range(gte: 1, lte: 2).to_h).
        to eq('range' => {'title' => {'gte' => 1, 'lte' => 2}})
    end

    it 'converts composite clauses' do
    end

    it 'converts clauses with nested fields' do
      expect(Lastic.field('author.name').nested.term('Vonnegut').to_h).
        to eq( 'nested' => {
          'path' => 'author',
          'filter' => {
            'term' => {'author.name' => 'Vonnegut'}
          }
        })
    end
  end
end
