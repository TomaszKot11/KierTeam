require 'spec_helper'
require 'rails_helper'

describe ApplicationHelper, type: :helper do

    describe '#custom_reference_problem' do

        URI_PARAMS_ = 'https://www.google.pl/search?q=capybara&safe=active&source=lnms&tbm=isch&sa=X&ved=0ahUKEwiF35WNus7cAhWChaYKHTQiARsQ_AUICigB&biw=1396&bih=759#imgrc=WgUQnznb4HuSOM:'

        it 'https://gogle.pl should return link described as google.pl' do
            expect(helper.custom_reference_problem('https://google.pl')).to eq(["<a href=\"https://https://google.pl\">google.pl</a>"])
        end

        it 'www.google.pl should return url described as google.pl' do
            expect(helper.custom_reference_problem('www.google.pl')).to eq(["<a href=\"https://www.google.pl\">google.pl</a>"])
        end

        it 'https://google.pl GOOGLE should return link described GOOGLE' do
            expect(helper.custom_reference_problem('https://google.pl GOOGLE')).to eq(["<a href=\"https://https://google.pl\">GOOGLE</a>"])
        end

        it 'URI_PARAMS_ should product valid shortcut' do
            expect(helper.custom_reference_problem(URI_PARAMS_)).to eq(["<a href=\"https://https://www.google.pl/search?q=capybara&amp;safe=active&amp;source=lnms&amp;tbm=isch&amp;sa=X&amp;ved=0ahUKEwiF35WNus7cAhWChaYKHTQiARsQ_AUICigB&amp;biw=1396&amp;bih=759#imgrc=WgUQnznb4HuSOM:\">google.pl</a>"])
        end

        it 'URI_PARAMS with name should produce valid link' do
            expect(helper.custom_reference_problem("#{URI_PARAMS_}  CAPYBARA")).to eq(["<a href=\"https://https://www.google.pl/search?q=capybara&amp;safe=active&amp;source=lnms&amp;tbm=isch&amp;sa=X&amp;ved=0ahUKEwiF35WNus7cAhWChaYKHTQiARsQ_AUICigB&amp;biw=1396&amp;bih=759#imgrc=WgUQnznb4HuSOM:\">CAPYBARA</a>"])
        end

        it 'www.google.pl GOOGLE should return link described GOOGLE' do
            expect(helper.custom_reference_problem('www.google.pl GOOGLE')).to eq(["<a href=\"https://www.google.pl\">GOOGLE</a>"])
        end

        it 'works on differenct URLs' do
            expect(helper.custom_reference_problem('https://youtube.com')).to eq(["<a href=\"https://https://youtube.com\">youtube.com</a>"])
            expect(helper.custom_reference_problem('www.facebook.com')).to eq(["<a href=\"https://www.facebook.com\">facebook.com</a>"])
            expect(helper.custom_reference_problem('http://www.wikipedia.com')).to eq(["<a href=\"https://http://www.wikipedia.com\">wikipedia.com</a>"])
        end
    end

end