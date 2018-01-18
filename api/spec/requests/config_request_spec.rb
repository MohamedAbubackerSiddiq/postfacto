#
# Postfacto, a free, open-source and self-hosted retro tool aimed at helping
# remote teams.
#
# Copyright (C) 2016 - Present Pivotal Software, Inc.
#
# This program is free software: you can redistribute it and/or modify
#
# it under the terms of the GNU Affero General Public License as
#
# published by the Free Software Foundation, either version 3 of the
#
# License, or (at your option) any later version.
#
#
#
# This program is distributed in the hope that it will be useful,
#
# but WITHOUT ANY WARRANTY; without even the implied warranty of
#
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#
# GNU Affero General Public License for more details.
#
#
#
# You should have received a copy of the GNU Affero General Public License
#
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
require 'rails_helper'

describe '/config' do
  describe 'GET /' do
    context 'before the 1st of September 2017' do
      before do
        CLOCK.time = Time.parse('2017-08-31 23:59:59 UTC')
      end

      it 'returns new terms as false' do
        get '/config', as: :json

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:new_terms]).to eq(false)
      end
    end

    context 'after the 31st of August 2017' do
      before do
        CLOCK.time = Time.parse('2017-09-01 00:00:01 UTC')
      end

      it 'returns new terms as true' do
        get '/config', as: :json

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:new_terms]).to eq(true)
      end
    end

    context 'before the 1st of October 2017' do
      before do
        CLOCK.time = Time.parse('2017-09-30 23:59:59 UTC')
      end

      it 'returns old terms as true' do
        get '/config', as: :json

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:old_terms]).to eq(true)
      end
    end

    context 'after the 30th of September 2017' do
      before do
        CLOCK.time = Time.parse('2017-10-01 00:00:01 UTC')
      end

      it 'returns old terms as false' do
        get '/config', as: :json

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data[:old_terms]).to eq(false)
      end
    end
  end
end
