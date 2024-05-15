BÀI TẬP LỚN LẬP TRÌNH PYTHON

HỌ VÀ TÊN: HOÀNG ĐỨC CHUNG   
LỚP: K56KMT.01
MSSV: K205480106048

ĐỀ TÀI: ỨNG DỤNG IOT TRONG VIỆC DỰ BÁO GIÁ XĂNG DẦU TẠI VIỆT NAM

1. Giới thiệu:
Website Dự Báo Giá Xăng Dầu là một ứng dụng web được phát triển để cung cấp thông tin về giá xăng dầu hiện tại và dự báo giá trong tương lai. Mục đích của ứng dụng là giúp người dùng cập nhật giá xăng dầu nhanh chóng cùng xu hướng giá của nó, từ đó đưa ra quyết định đầu tư hoặc lập kế hoạch tiêu dùng thông minh.

2. Yêu cầu chức năng:
Wesite Dự Báo Giá Xăng Dầu bao gồm các chức năng sau:
•	Hiển thị giá xăng dầu hiện tại từ nguồn tin đáng tin cậy.
(Nguồn từ trang web: https://www.pvoil.com.vn/truyen-thong/tin-gia-xang-dau)
•	Cập nhật dữ liệu giá xăng dầu và dự báo theo thời gian thực.
•	Dự báo giá xăng dầu trong tương lai, bao gồm các biểu đồ và phân tích.
•	Cung cấp giao diện người dùng thân thiện và dễ sử dụng.
•	Tương thích với nhiều trình duyệt và thiết bị khác nhau.

3. Công nghệ và công cụ sử dụng:
•	Ngôn ngữ lập trình: Python, HTML, CSS, Javascript, C#.
•	Framework/backend: FastAPI.
•	Cơ sở dữ liệu: Microsoft SQL Server.
•	Thư viện phân tích dữ liệu: Pandas, NumPy.
•	Thư viện dự báo: Prophet, ARIMA, LSTM.
•	Thư viện hiển thị biểu đồ: Chart.js hoặc D3.js.
•	Công cụ khác: NSSM, NODE-RED, IIS

4. Các bước thực hiện:
4.1. Tạo cơ sở dữ liệu
Xây dựng Cơ sở dữ liệu trên phần mềm Microsoft SQL Server. 
Bảng Dữ liệu "Fuel_Types" (Loại Xăng Dầu):
Bảng này lưu trữ thông tin về các loại xăng dầu khác nhau.
Field	Type	Description
id	INT	Khóa chính tự tăng
name	VARCHAR	Tên loại xăng dầu (ví dụ: Xăng RON 95)
Bảng Dữ liệu "Prices":
Bảng này lưu trữ các giá xăng dầu của từng loại dầu theo thời gian.
Field	Type	Description
id	INT	Khóa chính tự tăng
fuel_type_id	INT	Khóa ngoại tham chiếu đến "Fuel Types"
price	DECIMAL	Giá xăng dầu
timestamp	DATETIME	Thời điểm ghi nhận giá
Bảng Dữ liệu "Forecasts":
Bảng này lưu trữ các dự báo giá xăng dầu cho tương lai.
Field	Type	Description
id	INT	Khóa chính tự tăng
fuel_type_id	INT	Khóa ngoại tham chiếu đến "Fuel Types"
forecast	DECIMAL	Dự báo giá xăng dầu
created_at	DATETIME	Thời điểm tạo dự báo

Tạo thêm các Store Procedure:
 - SP_Fuel_Types (INSERT dữ liệu)
 - SP_Prices (INSERT dữ liệu)
 - SP_Forecasts (INSERT dữ liệu)
 - SP_Chart_Prices_Forecasts (SELECT dữ liệu)

Em đang vướng mắc chỗ này một chút về việc tạo SP_Chart để vẽ biểu đồ về sau:
 - TH1: Nếu nhu cầu là mỗi biểu đồ sẽ hiển thị Giá hiện tại và Giá dự đoán của 01 loại xăng dầu thì người dùng sẽ dễ dàng hình dung và so sánh hơn. Tuy nhiên nếu có thêm một loại xăng dầu nữa thì lại phải thêm SP nữa ạ?
 - TH2: Nếu nhu cầu là 01 biểu đồ về Giá hiện tại riêng và 01 biểu đồ về Giá dự đoán riêng thì sẽ cố định hơn về số lượng biểu đồ (số lượng SP). Tuy nhiên, người dùng chỉ so sánh được Giá hiện tại hoặc Giá dự đoán của 04 loại xăng mà không so sánh được Giá hiện tại và Giá dự đoán của 1 loại xăng mong muốn trên 01 biểu đồ.

4.2. Xây dựng API bằng việc sử dụng ngôn ngữ lập trình Python và Framework FastAPI
 - Ứng dụng Web scraping tự động lấy dữ liệu từ các trang web. Trang Web cụ thể ở đây đó chính là “Tin giá xăng dầu – TỔNG CÔNG TY DẦU VIỆT NAM” (đường dẫn: https://www.pvoil.com.vn/truyen-thong/tin-gia-xang-dau). Công cụ web scraping thường sử dụng trong Python là BeautifulSoup
 - Sau khi đã có dữ liệu thời gian thực (giá hiện tại) được lấy từ Website của các loại xăng dầu, ta sẽ lấy khoảng 30 giá gần nhất (số liệu này có thể thay đổi khi thử nghiệm thực tế) so với thời điểm hiện tại để đem đi phân tích và đưa ra dự đoán. Sử dụng các thư viện Pandas, NumPy để phân tích dữ liệu cho phù hợp với đầu vào của mô hình dự đoán giá. Một số thư viện dự đoán có thể ứng dụng được trong bài toán này có thể: Prophet, ARIMA, LSTM -  những mô hình này đều dựa vào “chuỗi thời gian” để đưa ra dự đoán.
 - Ứng dụng Framework FastAPI để tạo thành một API để sau đó Node-red (hoặc ứng dụng khác) có thể gọi API để lấy được toàn bộ dự liệu mong muốn.
 - Đồng thời, để cho API này luôn hoạt động đồng thời cùng máy tính thì ứng dụng phần mềm NSSM để đóng gói nó thành Server, thiết lập chạy cùng với hệ điều hành máy tính

4.3. Ứng dụng Node-red để gọi API và lưu trữ dữ liệu
Node-RED được dựa trên Node.js, nó có thể được xem như một web server mà bạn có thể cấu hình tùy chỉnh các chức năng gọi là “flow” từ bất kỳ trình duyệt nào trên máy tính. Mỗi ứng dụng Node-RED bao gồm các node có thể liên kết được với nhau với các dạng là input, output và operation.
Link học Node-red cơ bản: https://hocarm.org/node-red-co-ban/
	Sau khi cài đặt, trên giao diện của Node-red, tạo một chu trình tự động Gọi API (cái mà được đã tạo ở mục 4.2) để lấy dữ liệu cần thiết (Các loại xăng dầu, giá hiện tại, giá dự đoán của từng loại xăng, dầu). Sử dụng các Inject node, http request node, function,… để thực hiện điều đó. Thiết lập giá trị interval cho phù hợp để cập nhật giá xăng dầu thường xuyên.
	Khi đã có dữ liệu trả về, ta thực hiện lưu trữ dữ liệu vào database. Để thực hiện lưu trữ dữ liệu vào database trên Node-red, ta sử dụng thư viện MSSQL-PLUS. Cài đặt thư viện, kéo MSSQL-PLUS node vào vùng làm việc, kết nối với SQL Server, viết code SQL để gọi các SP_ nhằm lưu trữ dữ liệu được lấy từ API vào Cơ sở dữ liệu được tạo ở mục 4.1.

4.4. Sử dụng C# để truy vấn cơ sở dữ liệu và chuyển đổi thành JSON
	Sử dụng ADO.NET để kết nối và truy vấn cơ sở dữ liệu SQL Server trong ứng dụng C#. Viết mã C# để thực hiện truy vấn cơ sở dữ liệu và lấy dữ liệu từ các bảng “Fuel Types”, "Prices" và "Forecasts". Sau đó, chuyển dữ liệu lấy được thành các danh sách đối tượng, sau đó chuyển đổi thành JSON.

4.5. Xây dựng frontend – Hiển thị biểu đồ minh họa
Sử dụng HTML, CSS và Javascript để xây dựng giao diện người dùng.
Sử dụng JavaScript và AJAX để gửi yêu cầu HTTP đến ứng dụng C# của bạn.

Xử lý phản hồi JSON từ ứng dụng C# bằng cách sử dụng các hàm callback AJAX.
Sử dụng thư viện Chart.js hoặc D3.js để hiển thị biểu đồ Giá xăng dầu hiện tại và dự báo theo thời gian.

5. Kết quả và kết luận:
Ứng dụng Dự Báo Giá Xăng Dầu đã được phát triển thành công với các chức năng cơ bản như hiển thị giá xăng dầu hiện tại và dự báo giá trong tương lai. Giao diện người dùng thân thiện và dễ sử dụng, đáp ứng được nhu cầu của người dùng trong việc theo dõi và đưa ra dự báo về giá xăng dầu. 

