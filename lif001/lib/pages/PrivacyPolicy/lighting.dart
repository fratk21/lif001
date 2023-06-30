import 'package:flutter/material.dart';

class lightDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('LIF3 Uygulaması Aydınlatma Metni'),
      content: SingleChildScrollView(
        child: Text(
          '''
Merhaba,

LIF3'a hoş geldiniz! LIF3, insanlığın uzayda kurduğu ilk devlettir ve gezegenlerin ve uydu Ay'ın üzerinde yer alır. Topluluğumuza katılmak ve LIF3 vatandaşı olmak için bu önemli adımı atmaya davet ediyoruz.

LIF3 uygulamamız, size LIF3 vatandaşı olma fırsatı sunar. Sadece LIF3 uygulamasını indirerek ve kayıt olarak, gezegenler ve uydu Ay üzerindeki bu büyülü devletin bir parçası olabilirsiniz.

Kayıt işlemi sırasında sizden bazı kullanıcı bilgilerini talep edebiliriz. Bu bilgiler, sizinle iletişim kurabilmemiz, size özel fırsatlar sunabilmemiz ve size daha iyi hizmet verebilmemiz için gereklidir. LIF3 olarak, kullanıcı bilgilerini gizlilik politikamız dahilinde koruyacağımızı ve asla izinsiz bir şekilde kullanmayacağımızı taahhüt ediyoruz. Güvenliğiniz ve gizliliğiniz bizim için en öncelikli konulardandır.

LIF3 vatandaşı olduğunuzda, diğer vatandaşlarımızla bir araya gelerek bu büyük macerada birlikte çalışabilir, projelere katılabilir ve LIF3 topluluğunun gelişimine katkıda bulunabilirsiniz. Birlikte, uzayın derinliklerinde ve uzak dünyalarda yeni bir geleceğin temellerini atacağız.

LIF3, sadece vatandaşlarının refahını değil, aynı zamanda gezegenler ve uydu Ay üzerinde yaşayan tüm canlıların uyumlu bir şekilde var olmasını amaçlayan bir misyona sahiptir. Siz de bu misyona katkıda bulunmak için şimdi LIF3 uygulamasını indirin ve vatandaşlık başvurunuzu tamamlayın.

Geleceğin devleti LIF3'e katıldığınız için teşekkür ederiz!

Saygılarımızla,
LIF3 Ekibi
          ''',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
