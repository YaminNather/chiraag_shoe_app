// class Product {
//   const Product(this.name, this.image, this.price);

//   final String name;
//   final String image;
//   final double price;
// }

// const List<Product> products = <Product>[
//   Product(
//     'Nike Dunk Low Retro Green (2021)', 
//     'https://s3-alpha-sig.figma.com/img/bb78/893f/b9bb8fba64d177aa3f398df6b88a1018?Expires=1646006400&Signature=gAOykQIhHtxzYqob4BYs29XZrOVuZ2hsV-2Pj306UR09G0KQIEyuPiF6Ww9xZ6Smyn3gH2U95Jl9yhUtse0eFMqTzdxeXnv6YpTW5t0bEc01T0NpracOm1r3MNRNg01GJn6IxXpK6ne2jr1QUjTFhrnQdXixv5JArOGZQnc95qt085tVBCAM7RcbMrfuBsmte9EiozAkLEoaZzaCGEq5cV-zArmVyZlYT94wKj7AJOEpMlRtH9gsgnkHFmDUBVroMMe9L5TG2yVKdhu1cHbCUfvpJRAF7BwU9gJvRZnoGkPIWciIGWkdqEgqaS~pCouElE-JDMG21moXX3SpZ~2fbw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA', 
//     12000
//   ),
//   Product(
//     'Nike Jordan 1', 
//     'https://s3-alpha-sig.figma.com/img/3371/2bdb/6f2aabdeaf3aca0abe3c6350f3e8b354?Expires=1646006400&Signature=bVEZCEdz-m5sT4HkgIhOgGNXqWgq2fPO4vKrFBTnZJKLuaOVaJJop2~fx21tIZZ-5vkumgpARODcSywruB07ntwRE3wFFdchaQbyDOIq0G16NfklYkd1-FkYgj3z9lBIxRm~hm5bCI~29vcX4kmOyjfz-rZzUyIzgkdmgawQV2khKh5UYJSiI04rEHaWGjs27ETrvU0rxY0UaoAVOsgTKbSI9vfops5iFIRkpSirUyQGpVzulXJJ7XkSBX3l2Mh21MOHZyu9oGrD3PFnWi-EBeNWdfjrTmVRGCkUgSIntRIfGQq36p4dKYGAhYo9TkA-BZta4rSmDvGbnZmY~j3biw__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
//     12000
//   ),
//   Product(
//     'Nike Freerun', 
//     'https://s3-alpha-sig.figma.com/img/c051/ae60/760e1e158eb776c073d9f3281973d2dc?Expires=1646006400&Signature=BBeN3VrgFIGuhBgwRgEiXEqHA8E4vEhF1HR8l4JpyZibTYZKGxP8-g2RXOol3Lck57IaAULZ8YBZHn2Vixvjng1~JTHZLPXGTPICr9GlRn35HHV0dI8grRJlHjjI6IanAWkLwj8brXmJ2RdIBJbEkrO29t8HWeKA-enE4JI2vLsIc2RChxMXbV-X3q17ZXBT36X-up2FdfOshoVYB4QXlxvX7A3KKxMnpJg2mKXTbcaWCyFIqlUuqQ-BfQ5bemezUPFyr6fvjIQyYFzS8GNsb-1iJicpmMaHvxWJFDTvMbdegoCA6UrCs8ClonHeyy~d2vQqWFH2jawLSEKmhNbMAA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
//     12000
//   ),
//   Product(
//     'Adidas Yezzy 350', 
//     'https://s3-alpha-sig.figma.com/img/377d/170e/edb4c71e0738997a71f1fd9f15f6d52c?Expires=1646006400&Signature=bWea3debFM2c70DGkHjDqpoLsFXtzwkLTapk01SM9gM7CcWZs6p-5y01htB7cCl8zp1X~sT2EVQTptahH3du9P8UuuWjFpoM-Yz1GAtab2wRHSnywVk0PlkWozG~0qugAsF4E4iaO2Ycq8qt9GLdGfuSx7GVXgpPg5QxPONc0zyiph1D8zECgxKIKt7QZu7dnMr1Jqdu-8jyh0odvmm962j1Zrn3g2RynHfg~FIfklujY1OEzhUYcLd2mZ6GAZB4nxqDbc3OL05tl0Cei-PPWQk6Lg8va0K~-9ilCCOKsdVyyFVIcZA0WSctxR1MYtMQ7OfYLkwcYcoTjUVtP47R6Q__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA', 
//     12000
//   ),
//   Product(
//     'Nike Dunk Low Retro Green (2021)', 
//     'https://s3-alpha-sig.figma.com/img/f648/34e4/1ed2302ace3b688337b0aebaccdef13d?Expires=1646006400&Signature=EjdAI5PJ2-U-gVibsBasMohDx1y~eqy0a4iLdkoDRDx9ks7JEmf-uS9iHsd2pZYxdrfZAUTQueROL2s4qkauDxO5lqpF9AD3rBUZ9iYTbLdHMeAmKiscjCiO6W-kqx9rHReLGz3mWyqHX7KXxgxtKkhg20d4OYSaiYv1LUWu6hbDaI64vwsAEKGnUYC7rJQZbbTs98t-LPfzHdHKvHVtVT~90fHW7WGcDvKxGy7gnqwSew4~adaV2BSLnOu-aqbZ88Nhdh9cHdT-~awI6tdylVDxSHFjBUZEIA3U7vPr-9Gh8xxAjGT8d8f6~OQwepl4goM4lHq5Frs8Td4mI2ZxyA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA', 
//     12000
//   ),
//   Product(
//     'Nike Jordan 1', 
//     'https://s3-alpha-sig.figma.com/img/f992/f704/d0b338d7061009a5bb87a95aa906077b?Expires=1646006400&Signature=a6EkrYNm4ajfCa9j6XRgkhvbRPy8DVvky6yX0k3pRALzwoD6WOSvAcVPVRd5LJlZBmsqc7r9-wWpTdcMq1ZMNzVTqkdy5UNCDtfN39jowLKd90e2Vh3hvEf8v03eDVUmq2OjUR-QSKkczvuHS1aXs8Mb~B174oufBFFT5X521W41aYs3oJ3fM6TYOkU~o-ANwHfdWIiALWetaRJeCFUGLTal2dimJ4MWZK0PnnaXSOwJXo0zWz6y4y6kGsgW1jqX6xcwlC1r3604jFRYg5HLOPcmOvkvaQ3DCC7KC4m~49s-zO2-0yasgOxR4PMxEZj0uaC3r8U6JrxT8wEBd~stFQ__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
//     12000
//   ),
//   Product(
//     'Nike Freerun', 
//     'https://s3-alpha-sig.figma.com/img/c051/ae60/760e1e158eb776c073d9f3281973d2dc?Expires=1646006400&Signature=BBeN3VrgFIGuhBgwRgEiXEqHA8E4vEhF1HR8l4JpyZibTYZKGxP8-g2RXOol3Lck57IaAULZ8YBZHn2Vixvjng1~JTHZLPXGTPICr9GlRn35HHV0dI8grRJlHjjI6IanAWkLwj8brXmJ2RdIBJbEkrO29t8HWeKA-enE4JI2vLsIc2RChxMXbV-X3q17ZXBT36X-up2FdfOshoVYB4QXlxvX7A3KKxMnpJg2mKXTbcaWCyFIqlUuqQ-BfQ5bemezUPFyr6fvjIQyYFzS8GNsb-1iJicpmMaHvxWJFDTvMbdegoCA6UrCs8ClonHeyy~d2vQqWFH2jawLSEKmhNbMAA__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA',
//     12000
//   ),
//   Product(
//     'Adidas Yezzy 350', 
//     'https://s3-alpha-sig.figma.com/img/377d/170e/edb4c71e0738997a71f1fd9f15f6d52c?Expires=1646006400&Signature=bWea3debFM2c70DGkHjDqpoLsFXtzwkLTapk01SM9gM7CcWZs6p-5y01htB7cCl8zp1X~sT2EVQTptahH3du9P8UuuWjFpoM-Yz1GAtab2wRHSnywVk0PlkWozG~0qugAsF4E4iaO2Ycq8qt9GLdGfuSx7GVXgpPg5QxPONc0zyiph1D8zECgxKIKt7QZu7dnMr1Jqdu-8jyh0odvmm962j1Zrn3g2RynHfg~FIfklujY1OEzhUYcLd2mZ6GAZB4nxqDbc3OL05tl0Cei-PPWQk6Lg8va0K~-9ilCCOKsdVyyFVIcZA0WSctxR1MYtMQ7OfYLkwcYcoTjUVtP47R6Q__&Key-Pair-Id=APKAINTVSUGEWH5XD5UA', 
//     12000
//   ),
// ];