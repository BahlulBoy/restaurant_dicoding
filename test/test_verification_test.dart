import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_dicoding/constants/api_const.dart';
import 'package:restaurant_dicoding/models/detail_restaurant_response.dart';

import 'test_verification_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('parsingJson', () {
    test('return an Detail Restaurant Model from JSON', () async {
      final client = MockClient();

      when(
        client.get(
          Uri.parse(
            ApiConst.detail('rqdv5juczeskfw1e867'),
          ),
        ),
      ).thenAnswer((_) async {
        return http.Response(
          '{"error":false,"message":"success","restaurant":{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"},{"name":"Bebek crepes"},{"name":"Salad lengkeng"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"},{"name":"Jus apel"},{"name":"Jus jeruk"},{"name":"Coklat panas"},{"name":"Air"},{"name":"Es kopi"},{"name":"Jus alpukat"},{"name":"Jus mangga"},{"name":"Teh manis"},{"name":"Kopi espresso"},{"name":"Minuman soda"},{"name":"Jus tomat"}]},"rating":4.2,"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"}]}}',
          200,
        );
      });

      final result = await client.get(
        Uri.parse(
          ApiConst.detail('rqdv5juczeskfw1e867'),
        ),
      );

      final dataParse = DetailRestaurantResponse.fromRawJson(result.body);

      expect(dataParse, isA<DetailRestaurantResponse>());
      expect(dataParse.error, false);
      expect(dataParse.message, 'success');
      expect(dataParse.restaurant, isA<DetailRestaurant>());
      expect(dataParse.restaurant?.id, 'rqdv5juczeskfw1e867');
    });

    test(
      'return error response',
      () async {
        final client = MockClient();

        when(
          client.get(
            Uri.parse(
              ApiConst.detail('rqdv5juczeskfw1e867'),
            ),
          ),
        ).thenAnswer((_) async {
          return http.Response(
            '{"error":true,"message":"Restaurant not found"}',
            200,
          );
        });

        final result = await client.get(
          Uri.parse(
            ApiConst.detail('rqdv5juczeskfw1e867'),
          ),
        );

        final dataParse = DetailRestaurantResponse.fromRawJson(result.body);

        expect(dataParse, isA<DetailRestaurantResponse>());
        expect(dataParse.error, true);
        expect(dataParse.message, 'Restaurant not found');
        expect(dataParse.restaurant, null);
        expect(dataParse.restaurant?.id, null);
      },
    );
  });
}
