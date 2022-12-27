import 'package:flutter/material.dart';

var petRegulation = r'''
<h3 style="text-align:justify;">Quy dịnh về vật nuôi trong chung cư</h3>
<p style="text-align:justify;"><i><strong>Người nuôi chó, mèo phải tuân thủ quy định như sau:</strong></i></p>

<p style="text-align:justify;">1. Phải đăng ký việc nuôi chó với Ủy ban nhân dân cấp xã tại các đô thị, nơi đông dân cư;
</p>

<p style="text-align:justify;">2.Cư dân được nuôi chó, mèo có trọng lượng dưới 15 kg, chủ vật nuôi phải sử dụng thang
    máy tải hàng để di chuyển vật nuôi trong thời gian quy định.</p>

<p style="text-align:justify;">3. Xích, nhốt hoặc giữ chó trong khuôn viên gia đình; bảo đảm vệ sinh môi trường, không
    ảnh hưởng xấu tới người xung quanh. Khi đưa chó ra nơi công cộng phải bảo đảm an toàn cho người xung quanh bằng cách
    đeo rọ mõm cho chó hoặc xích giữ chó và có người dắt;</p>

<p style="text-align:justify;">4. Nuôi chó tập trung phải bảo đảm điều kiện vệ sinh thú y, không gây ồn ào, ảnh hưởng
    xấu tới những người xung quanh;</p>

<p style="text-align:justify;">5. Chấp hành tiêm vắc-xin phòng bệnh Dại cho chó, mèo theo quy định;</p>

<p style="text-align:justify;">6. Chịu mọi chi phí trong trường hợp có chó thả rông bị bắt giữ, kể cả chi phí cho việc
    nuôi dưỡng và tiêu hủy chó. Trường hợp chó, mèo cắn, cào người thì chủ vật nuôi phải bồi thường vật chất cho người
    bị hại theo quy định của pháp luật.</p>

<ul>
    <li style="text-align:justify;">Tại điểm b khoản 1 Điều 7 Nghị định số 144/2021/NĐ-CP ngày 31/12/2021 quy định xử
        phạt vi phạm hành chính trong lĩnh vực an ninh, trật tự an toàn xã hội; phòng, chống tệ nạn xã hội; phòng cháy,
        chữa cháy; cứu nạn, cứu hộ;</li>
    <li style="text-align:justify;">Khoản 1 Điều 7 Nghị định 167/2013/NĐ-CP, nếu nuôi gia súc, gia cầm, động vật gây mất
        vệ sinh chung ở khu dân cư; để gia súc, gia cầm hoặc các loại động vật nuôi phóng uế ở nơi công cộng sẽ bị phạt
        cảnh cáo hoặc phạt tiền từ 100.000-300.000 đồng với mỗi hành vi.</li>
</ul>
<p style="text-align:justify;"><span style="color:hsl(0, 75%, 60%);"><i>Trường hợp chủ hộ nuôi thú cưng có vi phạm, ban
            quản lý sẽ thông báo công khai đến toàn thể cư dân và phạt tiền từ 200.000-5.000.000 VNĐ, (tùy theo mức độ
            vi phạm)</i></span></p>
''';

var petR = const [
  Text('Quy dịnh về vật nuôi trong chung cư'),
  Text('Người nuôi chó, mèo phải tuân thủ quy định như sau:'),
  Text(
      '1. Phải đăng ký việc nuôi chó với Ủy ban nhân dân cấp xã tại các đô thị, nơi đông dân cư;'),
  Text(
      '2.Cư dân được nuôi chó, mèo có trọng lượng dưới 15 kg, chủ vật nuôi phải sử dụng thang máy tải hàng để di chuyển vật nuôi trong thời gian quy định.'),
  Text(
      '3. Xích, nhốt hoặc giữ chó trong khuôn viên gia đình; bảo đảm vệ sinh môi trường, không ảnh hưởng xấu tới người xung quanh. Khi đưa chó ra nơi công cộng phải bảo đảm an toàn cho người xung quanh bằng cách đeo rọ mõm cho chó hoặc xích giữ chó và có người dắt;'),
  Text(
      '4. Nuôi chó tập trung phải bảo đảm điều kiện vệ sinh thú y, không gây ồn ào, ảnh hưởng xấu tới những người xung quanh;'),
  Text('5. Chấp hành tiêm vắc-xin phòng bệnh Dại cho chó, mèo theo quy định;'),
  Text(
      '6. Chịu mọi chi phí trong trường hợp có chó thả rông bị bắt giữ, kể cả chi phí cho việc nuôi dưỡng và tiêu hủy chó. Trường hợp chó, mèo cắn, cào người thì chủ vật nuôi phải bồi thường vật chất cho người bị hại theo quy định của pháp luật.'),
  Text(
      'Tại điểm b khoản 1 Điều 7 Nghị định số 144/2021/NĐ-CP ngày 31/12/2021 quy định xử phạt vi phạm hành chính trong lĩnh vực an ninh, trật tự an toàn xã hội; phòng, chống tệ nạn xã hội; phòng cháy, chữa cháy; cứu nạn, cứu hộ;'),
  Text(
      'Khoản 1 Điều 7 Nghị định 167/2013/NĐ-CP, nếu nuôi gia súc, gia cầm, động vật gây mất vệ sinh chung ở khu dân cư; để gia súc, gia cầm hoặc các loại động vật nuôi phóng uế ở nơi công cộng sẽ bị phạt cảnh cáo hoặc phạt tiền từ 100.000-300.000 đồng với mỗi hành vi.'),
  Text(
      'Trường hợp chủ hộ nuôi thú cưng có vi phạm, ban quản lý sẽ thông báo công khai đến toàn thể cư dân và phạt tiền từ 200.000-5.000.000 VNĐ, (tùy theo mức độ vi phạm)'),
];
