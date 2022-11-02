enum PType { nomal, title, italic, bold, list }

const policies = [
  {
    "type": PType.title,
    'content': "CHÍNH SÁCH QUYỀN RIÊNG TƯ",
  },
  {
    "type": PType.nomal,
    'content':
        "Chính sách quyền riêng tư này mô tả cách thức Công ty cổ phần đầu tư phát triển Thần Nông (liên quan đến các dự án bất động sản), Công ty cổ phần đầu tư phát triển Thần Nông(sau đây gọi tắt là “Công Ty”) thu thập và sử dụng thông tin cá nhân của quý khách liên quan đến các trang web, ứng dụng, sản phẩm và dịch vụ của Công Ty (gọi chung là “Sản Phẩm Của Chúng Tôi”).",
  },
  {
    "type": PType.nomal,
    'content':
        "Chính sách quyền riêng tư này không áp dụng cho bất kỳ sản phẩm, dịch vụ, trang web hoặc nội dung nào được cung cấp bởi bên thứ ba hoặc có sử dụng chính sách quyền riêng tư riêng.",
  },
  {
    "type": PType.nomal,
    'content': "Chính sách này bao gồm các nội dung sau:",
  },
  {
    "type": PType.nomal,
    'content': "1. Thông tin cá nhân được chúng tôi thu thập",
  },
  {
    "type": PType.nomal,
    'content': "2. Cách thức chúng tôi sử dụng thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content': "3. Thu thập và sử dụng cookies",
  },
  {
    "type": PType.nomal,
    'content': "4. Cách thức chúng tôi chia sẻ thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content': "5. Cách thức chúng tôi bảo vệ thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content': "6. Quảng cáo trên Internet và bên thứ ba",
  },
  {
    "type": PType.nomal,
    'content': "7. Truy cập và lựa chọn",
  },
  {
    "type": PType.nomal,
    'content': "8. Thông tin cá nhân của người chưa thành niên",
  },
  {
    "type": PType.nomal,
    'content': "9. Thời hạn lưu trữ thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content': "10. Thông tin liên lạc, thông báo và sửa đổi",
  },
  {
    "type": PType.bold,
    'content': "1. Thông tin cá nhân được chúng tôi thu thập",
  },
  {
    "type": PType.nomal,
    'content':
        "Chúng tôi thu thập thông tin cá nhân của quý khách trong quá trình cung cấp Sản Phẩm Của Chúng Tôi cho quý khách.",
  },
  {
    "type": PType.nomal,
    'content': "Dưới đây là các nguồn thông tin được chúng tôi thu thập:",
  },
  {
    "type": PType.list,
    'content':
        "Thông tin quý khách cung cấp cho chúng tôi: Chúng tôi thu thập bất kỳ thông tin nào quý khách cung cấp liên quan đến Sản Phẩm Của Chúng Tôi.",
  },
  {
    "type": PType.list,
    'content':
        "Thông tin tự động: Chúng tôi tự động thu thập một số loại thông tin nhất định khi quý khách tương tác với Sản Phẩm Của Chúng Tôi",
  },
  {
    "type": PType.list,
    'content':
        "Thông tin từ các nguồn khác: Chúng tôi có thể thu thập thông tin về quý khách từ các nguồn khác, bao gồm nhà cung cấp dịch vụ, đối tác và các nguồn công khai có sẵn.",
  },
  {
    "type": PType.bold,
    'content': "2. Cách thức chúng tôi sử dụng thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content': "",
  },
  {
    "type": PType.nomal,
    'content':
        "Chúng tôi sử dụng thông tin cá nhân của quý khách để vận hành, cung cấp và cải thiện Sản Phẩm Của Chúng Tôi. Mục đích sử dụng thông tin cá nhân của chúng tôi bao gồm:",
  },
  {
    "type": PType.list,
    'content':
        "Vận hành, Cung cấp Sản Phẩm Của Chúng Tôi: Chúng tôi sử dụng thông tin cá nhân của quý khách để vận hành, cung cấp và giao Sản Phẩm Của Chúng Tôi và xử lý các giao dịch liên quan đến Sản Phẩm Của Chúng Tôi, bao gồm nhưng không giới hạn đến việc đăng ký, mua hàng, tham gia các chương trình ưu đãi, cung cấp dịch vụ quản lý, vận hành các Sản Phẩm Của Chúng Tôi, thanh toán và nhận bàn giao hàng.",
  },
  {
    "type": PType.list,
    'content':
        "Đo lường, hỗ trợ và cải thiện Sản Phẩm Của Chúng Tôi: Chúng tôi sử dụng thông tin cá nhân của quý khách để đo lường việc sử dụng, phân tích hiệu suất, sửa lỗi, cung cấp hỗ trợ, cải thiện chất lượng và phát triển Sản Phẩm Của Chúng Tôi.",
  },
  {
    "type": PType.list,
    'content':
        "Đưa ra khuyến nghị và cá nhân hóa trải nghiệm: Chúng tôi sử dụng thông tin cá nhân của quý khách để đề xuất Sản Phẩm Của Chúng Tôi mà quý khách có thể quan tâm, nhận diện sở thích của quý khách và cá nhân hóa trải nghiệm của quý khách với Sản Phẩm Của Chúng Tôi.",
  },
  {
    "type": PType.list,
    'content':
        "Tuân thủ nghĩa vụ pháp lý: Trong một số trường hợp nhất định, chúng tôi có nghĩa vụ pháp lý để thu thập, sử dụng hoặc lưu trữ thông tin cá nhân của quý khách.",
  },
  {
    "type": PType.list,
    'content':
        "Liên lạc với quý khách: Chúng tôi sử dụng thông tin cá nhân của quý khách để liên lạc với quý khách liên quan đến Sản Phẩm Của Chúng Tôi thông qua các kênh khác nhau (ví dụ: email, chat) và để trả lời yêu cầu của quý khách.",
  },
  {
    "type": PType.list,
    'content':
        "Tiếp thị: Chúng tôi sử dụng thông tin cá nhân của quý khách để tiếp thị và quảng bá Sản Phẩm Của Chúng Tôi theo quy định của pháp luật. Chúng tôi có thể hiển thị quảng cáo Sản Phẩm Của Chúng Tôi dựa trên sở thích của quý khách.",
  },
  {
    "type": PType.list,
    'content':
        "Phòng chống gian lận và lạm dụng, rủi ro tín dụng: Chúng tôi sử dụng thông tin cá nhân của quý khách để ngăn chặn và phát hiện gian lận và lạm dụng nhằm bảo vệ an ninh của khách hàng, chúng tôi và những người khác. Chúng tôi cũng có thể sử dụng các phương pháp chấm điểm để đánh giá và quản trị rủi ro tín dụng.",
  },
  {
    "type": PType.list,
    'content':
        "Một số mục đích cụ thể cần sự đồng ý của quý khách: Chúng tôi có thể xin chấp thuận của quý khách về việc sử dụng thông tin cá nhân cho một mục đích cụ thể nào đó khi chúng tôi liên hệ với quý khách.",
  },
  {
    "type": PType.bold,
    'content': "3. Thu thập và sử dụng cookies",
  },
  {
    "type": PType.nomal,
    'content':
        "Chúng tôi sử dụng cookies, pixel và các công nghệ tương tự khác (gọi chung là “cookies”) để nhận diện trình duyệt hoặc thiết bị của quý khách, tìm hiểu thêm về sở thích của quý khách, cung cấp cho quý khách các tính năng và dịch vụ thiết yếu và cho các mục đích bổ sung khác, bao gồm:",
  },
  {
    "type": PType.list,
    'content':
        "Nhận diện quý khách khi quý khách đăng nhập sử dụng dịch vụ của chúng tôi. Điều này cho phép chúng tôi cung cấp cho quý khách các đề xuất, hiển thị nội dung được cá nhân hóa và cung cấp các tính năng và dịch vụ tùy chỉnh khác.",
  },
  {
    "type": PType.list,
    'content':
        "Lưu tâm đến các tùy chọn mà quý khách đã chấp thuận. Điều này cho phép chúng tôi tôn trọng những điều quý khách thích và không thích, chẳng hạn như ngôn ngữ và cấu hình mà quý khách lựa chọn.",
  },
  {
    "type": PType.list,
    'content':
        "Tiến hành nghiên cứu và phân tích để cải thiện Sản Phẩm Của Chúng Tôi. ",
  },
  {
    "type": PType.list,
    'content': "Ngăn chặn hành vi gian lận.",
  },
  {
    "type": PType.list,
    'content': "Cải thiện an ninh. ",
  },
  {
    "type": PType.list,
    'content':
        "Cung cấp nội dung, bao gồm quảng cáo, có liên quan đến sở thích của quý khách trên các trang web của chúng tôi và trang web của bên thứ ba.",
  },
  {
    "type": PType.list,
    'content':
        "Đo lường và phân tích chất lượng của các Sản Phẩm Của Chúng Tôi. ",
  },
  {
    "type": PType.nomal,
    'content':
        "Cookies cho phép quý khách tận dụng một số tính năng cần thiết của chúng tôi. Ví dụ, nếu quý khách chặn hoặc từ chối cookies của chúng tôi, quý khách sẽ không thể sử dụng một số sản phẩm, dịch vụ nhất định yêu cầu quý khách đăng nhập hoặc quý khách có thể phải tự tay điều chỉnh một số tùy chọn hoặc cài đặt ngôn ngữ mỗi khi quý khách truy cập lại các trang web của chúng tôi.",
  },
  {
    "type": PType.nomal,
    'content':
        "Các bên thứ ba được chấp thuận cũng có thể đặt cookies khi quý khách tương tác với các Sản Phẩm Của Chúng Tôi. Các bên thứ ba này thường bao gồm các công cụ tìm kiếm, nhà cung cấp dịch vụ đo lường và phân tích, mạng xã hội và các công ty quảng cáo. Các bên thứ ba sử dụng cookies trong quá trình cung cấp nội dung, bao gồm quảng cáo liên quan đến sở thích của quý khách, để đo lường hiệu quả của quảng cáo và thực hiện một số dịch vụ thay mặt cho chúng tôi.",
  },
  {
    "type": PType.nomal,
    'content':
        "Quý khách có thể quản lý cookies trình duyệt bằng việc cài đặt trình duyệt của mình. Tính năng 'Trợ giúp' trên hầu hết các trình duyệt sẽ cho quý khách biết cách ngăn trình duyệt chấp nhận các cookies mới, cách trình duyệt thông báo cho quý khách khi quý khách nhận được cookies mới, cách tắt cookies và khi cookies hết hạn. Nếu quý khách tắt tất cả cookies trên trình duyệt của mình, cả chúng tôi và bên thứ ba sẽ không thể chuyển cookies sang trình duyệt của quý khách. Tuy nhiên, nếu quý khách làm điều này, quý khách có thể phải tự tay điều chỉnh một số tùy chọn mỗi khi quý khách truy cập lại trang web và một số tính năng và dịch vụ có thể không hoạt động.",
  },
  {
    "type": PType.bold,
    'content': "4. Cách thức chúng tôi chia sẻ thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content':
        "Thông tin về khách hàng là một phần quan trọng trong hoạt động của chúng tôi, và chúng tôi không bán thông tin cá nhân của khách hàng cho người khác. Chúng tôi chỉ chia sẻ thông tin cá nhân như được nêu dưới đây. Chúng tôi cũng chia sẻ thông tin cá nhân cho công ty Thần Nông, và các công ty con của Tập đoàn Thần Nông các công ty này đều tuân thủ Chính sách quyền riêng tư này hoặc chính sách tương tự.",
  },
  {
    "type": PType.list,
    'content':
        "Giao dịch liên quan đến bên thứ ba: Chúng tôi cung cấp cho quý khách các dịch vụ, phần mềm và nội dung do bên thứ ba cung cấp để sử dụng trên hoặc thông qua Sản Phẩm Của Chúng Tôi. Quý khách có thể biết khi nào bên thứ ba tham gia vào các giao dịch của quý khách và chúng tôi sẽ chia sẻ thông tin liên quan đến các giao dịch đó với bên thứ ba.",
  },
  {
    "type": PType.list,
    'content':
        "Bên thứ ba cung cấp dịch vụ: Chúng tôi sử dụng và/hoặc hợp tác với các công ty và cá nhân khác để thực hiện một số công việc và chương trình như chương trình ưu đãi, bán hàng chéo,... dành cho quý khách. Ví dụ bao gồm: gửi thông tin liên lạc, xử lý thanh toán, đánh giá rủi ro tín dụng và tuân thủ, thực hiện chương trình hỗ trợ lãi suất, xử lý tài sản bảo đảm, phân tích dữ liệu, cung cấp hỗ trợ tiếp thị và bán hàng (bao gồm quản lý quảng cáo và sự kiện), quản lý quan hệ khách hàng và đào tạo. Các bên thứ ba cung cấp dịch vụ này có quyền truy cập vào thông tin cá nhân cần thiết để thực hiện các chức năng của họ, nhưng không được sử dụng cho các mục đích khác. Ngoài ra, họ phải tuân thủ Chính sách quyền riêng tư này và pháp luật về bảo vệ quyền riêng tư liên quan.",
  },
  {
    "type": PType.nomal,
    'content':
        "Tái cấu trúc, Chuyển nhượng doanh nghiệp/Dự án: Trong quá trình phát triển kinh doanh, chúng tôi có thể bán hoặc mua các doanh nghiệp hoặc tái cấu trúc doanh nghiệp hoặc chuyển nhượng Dự án hoặc dịch vụ khác phù hợp với quy định của pháp luật. Trong các giao dịch như vậy, thông tin cá nhân, cơ sở dữ liệu và quyền sử dụng thông tin nói chung là một trong những tài sản kinh doanh được chuyển nhượng nhưng bên nhận chuyển nhượng vẫn phải tuân theo các quy định của Chính sách quyền riêng tư này (hoặc khi được khách hàng chấp thuận).Ngoài ra, trong trường hợp Công Ty hoặc phần lớn tài sản của Công Ty được một công ty khác mua, thông tin của quý khách sẽ trở thành một trong những tài sản được chuyển nhượng.",
  },
  {
    "type": PType.nomal,
    'content':
        "Bảo vệ chúng tôi và những người khác: Chúng tôi tiết lộ tài khoản và thông tin cá nhân khác khi chúng tôi tin rằng việc đó là phù hợp để tuân thủ pháp luật, để thực thi hoặc áp dụng các điều khoản và thỏa thuận khác của chúng tôi hoặc để bảo vệ quyền, tài sản hoặc an ninh của chúng tôi, khách hàng của chúng tôi, hoặc bất kỳ người nào khác. Các công việc nêu trên có thể bao gồm việc trao đổi thông tin với các công ty và tổ chức khác để ngăn chặn và phát hiện gian lận và giảm thiểu rủi ro tài sản và tín dụng.",
  },
  {
    "type": PType.nomal,
    'content':
        "Tùy theo sự lựa chọn của quý khách: Ngoài các quy định trên, quý khách sẽ nhận được thông báo khi thông tin cá nhân về quý khách có thể được chia sẻ với bên thứ ba và quý khách sẽ có quyền không chấp thuận việc chia sẻ thông tin.",
  },
  {
    "type": PType.bold,
    'content': "5. Cách thức chúng tôi bảo vệ thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content':
        "Tại Công Ty, bảo mật là ưu tiên cao nhất của chúng tôi. Hệ thống của chúng tôi được thiết kế có tính đến khả năng bảo đảm an toàn và riêng tư cho thông tin của quý khách.",
  },
  {
    "type": PType.nomal,
    'content':
        "Chúng tôi đã thuê bên thứ ba thực hiện kiểm soát an ninh bảo mật để ngăn chặn việc truy cập, sử dụng trái phép thông tin cá nhân. Chúng tôi cũng thường xuyên phối hợp với các chuyên gia bảo mật nhằm cập nhật những thông tin mới nhất về an ninh mạng để đảm bảo sự an toàn cho thông tin cá nhân.Khi thu thập dữ liệu, chúng tôi thực hiện lưu giữ và bảo mật thông tin cá nhân tại hệ thống máy chủ và các thông tin cá nhân này được bảo đảm an toàn bằng các hệ thống tường lửa, các biện pháp kiểm soát truy cập, mã hóa dữ liệu theo chuẩn quốc tế.",
  },
  {
    "type": PType.nomal,
    'content':
        "Các thông tin thẻ thanh toán của quý khách do các tổ chức tài chính phát hành được chúng tôi bảo vệ theo tiêu chuẩn quốc tế với nguyên tắc không ghi nhận các dữ liệu quan trọng của thẻ thanh toán (số thẻ, họ tên, số CVV) trên hệ thống của chúng tôi.Giao dịch thanh toán của quý khách được thực hiện trên hệ thống của ngân hàng liên quan.",
  },
  {
    "type": PType.bold,
    'content': "6. Quảng cáo trên Internet và bên thứ ba",
  },
  {
    "type": PType.nomal,
    'content':
        "Các Sản Phẩm Của Chúng Tôi có thể bao gồm quảng cáo của bên thứ ba và đường link tới các trang web và ứng dụng khác. Các đối tác quảng cáo bên thứ ba có thể thu thập thông tin về quý khách khi quý khách tương tác với nội dung, quảng cáo hoặc dịch vụ của họ.",
  },
  {
    "type": PType.bold,
    'content': "7. Truy cập và lựa chọn",
  },
  {
    "type": PType.nomal,
    'content':
        "Quý khách có thể xem, cập nhật và xóa một số thông tin nhất định về tài khoản và các tương tác của quý khách với Sản Phẩm Của Chúng Tôi. Nếu quý khách không thể tự truy cập hoặc cập nhật thông tin của mình, quý khách luôn có thể liên hệ với chúng tôi để được hỗ trợ.",
  },
  {
    "type": PType.nomal,
    'content':
        "Quý khách có nhiều lựa chọn về việc thu thập và sử dụng thông tin cá nhân của quý khách. Nhiều Sản Phẩm Của Chúng Tôi bao gồm chức năng cho phép quý khách tùy chọn về cách thông tin của quý khách đang được sử dụng. Quý khách có thể chọn không cung cấp một số thông tin nhất định, nhưng sau đó quý khách có thể không tận dụng được một số Sản Phẩm Của Chúng Tôi.",
  },
  {
    "type": PType.nomal,
    'content':
        "Trình duyệt và thiết bị: Tính năng Trợ giúp trên hầu hết các trình duyệt và thiết bị sẽ cho quý khách biết cách ngăn trình duyệt hoặc thiết bị của mình chấp nhận cookies mới, làm thế nào để trình duyệt thông báo cho quý khách khi quý khách nhận được cookies mới hoặc cách tắt hẳn chức năng cookies.",
  },
  {
    "type": PType.bold,
    'content': "8. Thông tin cá nhân của người chưa thành niên",
  },
  {
    "type": PType.nomal,
    'content':
        "Nếu quý khách dưới 18 tuổi, quý khách phải có sự đồng ý của cha, mẹ hoặc người giám hộ trước khi ký kết hợp đồng và chấp thuận Chính sách quyền riêng tư này.",
  },
  {
    "type": PType.bold,
    'content': "9. Thời hạn lưu trữ thông tin cá nhân",
  },
  {
    "type": PType.nomal,
    'content':
        "Chúng tôi lưu trữ thông tin cá nhân của quý khách để đảm bảo cho quý khách khả năng sử dụng liên tục các Sản Phẩm Của Chúng Tôi, và lưu trữ trong thời hạn cần thiết để thực hiện được các mục tiêu quy định tại Chính sách quyền riêng tư này, hoặc theo quy định của pháp luật (bao gồm cả cho mục đích thuế và kế toán), hoặc để thực hiện các công việc khác như được thông báo trước cho quý khách. Thời gian chúng tôi lưu giữ thông tin cá nhân cụ thể khác nhau tùy thuộc vào mục đích sử dụng và chúng tôi sẽ xóa thông tin cá nhân của quý khách theo quy định của pháp luật hiện hành.",
  },
  {
    "type": PType.bold,
    'content': "10. Thông tin liên lạc, thông báo và sửa đổi",
  },
  {
    "type": PType.nomal,
    'content':
        "Nếu quý khách có bất kỳ câu hỏi nào về quyền riêng tư của Công Ty hoặc muốn liên hệ với đơn vị kiểm soát thông tin của chúng tôi, vui lòng liên hệ với chúng tôi và chúng tôi sẽ cố gắng trả lời câu hỏi của quý khách.",
  },
  {
    "type": PType.nomal,
    'content':
        "Hoạt động kinh doanh của chúng tôi liên tục thay đổi và Chính sách quyền riêng tư này cũng có thể được sửa đổi. Quý khách nên truy cập và kiểm tra trang web của chúng tôi thường xuyên để cập nhật những thay đổi gần nhất. Trừ trường hợp có quy định khác, Chính sách quyền riêng tư hiện tại của chúng tôi áp dụng cho tất cả thông tin cá nhân chúng tôi có về quý khách và tài khoản của quý khách. Việc sửa đổi Chính sách này trong mọi trường hợp sẽ không làm giảm mức độ bảo vệ thông tin cá nhân được thu thập trong quá khứ mà không thông báo cho khách hàng liên quan và cho quý khách được quyền lựa chọn.",
  },
  {
    "type": PType.bold,
    'content': "11. Ví dụ về các thông tin được chúng tôi thu thập",
  },
  {
    "type": PType.nomal,
    'content': "Thông tin quý khách cung cấp cho chúng tôi",
  },
  {
    "type": PType.nomal,
    'content':
        "Quý khách chủ yếu cung cấp thông tin cho chúng tôi khi quý khách:tìm kiếm, đăng ký hoặc mua bán, sử dụng Sản Phẩm Của Chúng Tôi Tạo hoặc quản lý tài khoản của quý khách;cấu hình cài đặt của quý khách cho, cung cấp quyền truy cập dữ liệu cho, hoặc tương tác với Sản Phẩm Của Chúng Tôi; đăng ký hoặc tham dự một sự kiện của Công Ty mua hoặc sử dụng nội dung, sản phẩm hoặc dịch vụ từ các nhà cung cấp bên thứ ba thông qua trang web hoặc ứng dụng của Công Ty (hoặc các địa điểm tương tự khác do chúng tôi điều hành hoặc cung cấp);cung cấp nội dung, sản phẩm hoặc dịch vụ của quý khách trên hoặc thông qua Sản Phẩm Của Chúng Tôi hoặc trang web hoặc ứng dụng của Công Ty (hoặc các địa điểm tương tự khác do chúng tôi điều hành hoặc cung cấp);liên lạc với chúng tôi qua tất cả các phương tiện chính thống như tổng đài chăm sóc khách hàng, gọi điện, email;đăng tải nội dung trên các trang web hoặc ứng dụng của Công Ty hoặc các địa điểm tương tự. Tùy thuộc vào việc quý khách sử dụng Sản Phẩm Của Chúng Tôi, quý khách có thể cung cấp cho chúng tôi các thông tin ví dụ như:tên, địa chỉ email, địa chỉ thường trú, địa chỉ liên hệ, số điện thoại và thông tin liên lạc tương tự khác;thông tin thanh toán, bao gồm thông tin thẻ tín dụng và tài khoản ngân hàng; thông tin về vị trí của quý khách; thông tin về tổ chức của quý khách và đầu mối liên hệ của quý khách, chẳng hạn như đồng nghiệp hoặc những người trong tổ chức của quý khách;tên người dùng, bí danh, vai trò và thông tin xác thực và bảo mật khác;nội dung phản hồi, lời chứng thực, câu hỏi, trao đổi với chúng tôi; hình ảnh của quý khách (tĩnh, video và trong một số trường hợp 3-D), giọng nói và các đặc điểm nhận dạng cá nhân khác của quý khách khi quý khách tham dự một sự kiện của Công Ty hoặc sử dụng một số Sản Phẩm Của Chúng Tôi;thông tin liên quan đến danh tính, bao gồm thông tin nhận dạng do chính phủ cấp, quốc tịch; thông tin tài chính và doanh nghiệp; và Số VAT, mã số thuế TNCN và các định danh thuế khác.",
  },
  {
    "type": PType.nomal,
    'content': "Thông tin tự động",
  },
  {
    "type": PType.nomal,
    'content':
        "Chúng tôi chủ yếu thu thập thông tin tự động khi quý khách:truy cập, tương tác hoặc sử dụng Sản Phẩm Của Chúng Tôi (kể cả khi quý khách sử dụng máy tính hoặc thiết bị khác để tương tác với Sản Phẩm Của Chúng Tôi);tải nội dung từ chúng tôi; mở email hoặc nhấp vào liên kết trong email từ chúng tôi; và tương tác hoặc liên lạc với chúng tôi.",
  },
  {
    "type": PType.nomal,
    'content': "Ví dụ về các thông tin được chúng tôi thu thập tự động:",
  },
  {
    "type": PType.nomal,
    'content':
        "thông tin mạng và kết nối, như địa chỉ giao thức Internet (IP) được sử dụng để kết nối máy tính (hoặc thiết bị khác) với Internet và thông tin về nhà cung cấp dịch vụ Internet của quý khách;",
  },
  {
    "type": PType.nomal,
    'content':
        "thông tin về máy tính và thiết bị, chẳng hạn như thiết bị, ứng dụng, hoặc loại và phiên bản trình duyệt, loại và phiên bản của plug-in của trình duyệt, hệ điều hành hoặc cài đặt múi giờ;vị trí của thiết bị hoặc máy tính của quý khách thông tin xác thực và bảo mật;thông tin tương tác nội dung, chẳng hạn như nội dung được tải xuống, luồng và chi tiết phát lại, bao gồm thời lượng và số lượng luồng và tải xuống đồng thời;",
  },
  {
    "type": PType.nomal,
    'content':
        "Các số liệu Sản Phẩm Của Chúng Tôi, chẳng hạn như việc sử dụng sản phẩm, lỗi kỹ thuật, báo cáo, tùy chọn cài đặt của quý khách, thông tin sao lưu backup, API calls, và nhật ký khác;nội dung quý khách đã xem hoặc tìm kiếm, thời gian phản hồi của trang web, ứng dụng, và thông tin tương tác trang (như cuộn, nhấp chuột);địa chỉ email và số điện thoại được sử dụng để liên hệ với chúng tôi; và thông tin nhận dạng và thông tin có trong. Thông tin từ các nguồn khác",
  },
  {
    "type": PType.nomal,
    'content':
        "Ví dụ về các thông tin chúng tôi có được từ các nguồn khác:thông tin tiếp thị, tạo doanh số và tuyển dụng, bao gồm tên, địa chỉ email, địa chỉ thực, số điện thoại và thông tin liên hệ tương tự khác;",
  },
  {
    "type": PType.nomal,
    'content':
        "thông tin về đăng ký, mua, hỗ trợ hoặc thông tin khác về tương tác của quý khách với các sản phẩm, dịch vụ của chúng tôi hoặc với các sản phẩm của bên thứ ba liên quan đến Sản Phẩm Của Chúng Tôi;",
  },
  {
    "type": PType.nomal,
    'content':
        "kết quả tìm kiếm và liên kết, bao gồm các danh sách sản phẩm, dịch vụ được trả tiền (như Liên kết được Tài trợ); và thông tin lịch sử tín dụng. ",
  },
];
