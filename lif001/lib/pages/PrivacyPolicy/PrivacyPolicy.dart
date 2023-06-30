import 'package:flutter/material.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('LIF3 Uygulaması Gizlilik ve Kullanım Sözleşmesi'),
      content: SingleChildScrollView(
        child: Text(
          '''
1. Giriş
LIF3 uygulamasını kullanarak LIF3 vatandaşı olmak için, aşağıdaki gizlilik ve kullanım sözleşmesini kabul etmeniz gerekmektedir. Lütfen bu sözleşmeyi dikkatlice okuyunuz. Bu sözleşme, sizinle (Kullanıcı) ve LIF3 şirketi (LIF3) arasında yapılan anlaşmayı ve uygulamanın kullanımını düzenlemektedir.

2. Kişisel Bilgilerin Toplanması ve Kullanımı
LIF3, LIF3 uygulamasını kullanırken sizden belirli kişisel bilgileri talep edebilir. Bu bilgiler, adınız, e-posta adresiniz, doğum tarihiniz gibi kimlik bilgilerinizi içerebilir. Bu bilgilerin toplanma amacı, sizinle iletişim kurmak, uygulama içindeki etkinlikleri duyurmak, ödüller sunmak ve size daha iyi hizmet vermek içindir. Toplanan bilgiler, LIF3 gizlilik politikasına uygun olarak kullanılacak ve asla izinsiz olarak üçüncü taraflarla paylaşılmayacaktır.

3. Bilgi Güvenliği
LIF3, kullanıcı bilgilerinin güvenliğini en üst düzeyde tutmaya özen gösterir. Kişisel verileriniz, uygun güvenlik önlemleriyle korunacak ve yetkisiz erişime karşı korunacaktır. Ancak, internet tabanlı bir hizmet olduğu için tamamen güvenliğini garanti edemeyiz. LIF3, veri güvenliği için gerekli önlemleri alırken, kullanıcıların kişisel bilgilerini paylaşırken dikkatli olmalarını ve güçlü parolalar kullanmalarını önerir.

4. Çerezler ve Takip Teknolojileri
LIF3 uygulaması, kullanıcı deneyimini geliştirmek ve daha iyi hizmet sunmak için çerezler ve benzeri takip teknolojilerini kullanabilir. Bu teknolojiler, kullanıcıları tanımak ve tercihlerini hatırlamak için kullanılır. Kullanıcılar, tarayıcı ayarlarından çerezleri kabul etmeyi reddedebilir, ancak bu durumda bazı uygulama özellikleri etkin olmayabilir.

5. Uygulama Güncellemeleri
LIF3, uygulama güncellemeleri yayınlayabilir ve bu güncellemeler, kullanıcı deneyimini geliştirmek, hataları düzeltmek veya yeni özellikler eklemek amacıyla yapılabilir. Güncellemelerin yüklenmesi, daha iyi bir kullanıcı deneyimi için önemlidir ve kullanıcılar tarafından yapılması önerilir.

6. Üçüncü Taraf Bağlantıları
LIF3 uygulaması, üçüncü taraf web sitelerine veya hizmetlere bağlantılar içerebilir. Bu bağlantılar, kullanıcıların bağımsız olarak ziyaret edebileceği kaynaklara yönlendirebilir. Bu üçüncü taraf sitelerin gizlilik politikalarından ve kullanım şartlarından LIF3 sorumlu değildir. Lütfen bu siteleri ziyaret etmeden önce ilgili gizlilik politikalarını okuyunuz.

7. Sözleşmenin Değişikliği
LIF3, bu gizlilik ve kullanım sözleşmesini zaman zaman güncelleyebilir. Sözleşmede yapılan değişiklikler, uygulama içinde veya web sitesinde yayınlanacaktır. Güncellenmiş sözleşmeyi gözden geçirmeniz önerilir. Sözleşmenin devamlı kullanımı, yapılan değişiklikleri kabul ettiğiniz anlamına gelir.

8. İletişim
Gizlilik ve kullanım sözleşmesi ile ilgili sorularınız veya bildirimleriniz için lütfen www.lif3.space üzerinden bize ulaşın.

Son Güncelleme Tarihi: 04/07/2023
          ''',
          style: TextStyle(fontSize: 16),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Gizlilik ve kullanım sözleşmesini kabul etme işlemi burada gerçekleştirilebilir.
            Navigator.pop(context);
          },
          child: Text('Kabul Ediyorum'),
        ),
      ],
    );
  }
}
