class Status < ActiveHash::Base
 self.data = [
   { id: 1, name: '---' },
   { id: 2, name: '未受領' },
   { id: 3, name: '処理中' },
   { id: 4, name: '処理済' },
 ]
end