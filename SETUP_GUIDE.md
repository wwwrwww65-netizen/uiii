# دليل إعداد التطبيق - حل مشاكل التعطل

## المشكلة الرئيسية
إذا كان التطبيق يتعطل عند التشغيل على Android، فالسبب الأكثر شيوعاً هو عدم تكوين المتغيرات البيئية بشكل صحيح.

## الحلول السريعة

### 1. للاختبار المحلي (بدون WooSignal)
```bash
# انسخ ملف الإعداد المحلي
cp .env.local .env

# أو استخدم إعدادات الديمو
flutter build apk --dart-define=DISABLE_FIREBASE=true --dart-define=APP_KEY=demo_key
```

### 2. للاستخدام الحقيقي
1. سجل في [WooSignal](https://woosignal.com/dashboard)
2. احصل على `APP_KEY` الخاص بك
3. عدّل ملف `.env`:
```env
APP_KEY="your_real_woosignal_key"
APP_URL="https://your-woocommerce-store.com"
API_BASE_URL="https://your-woocommerce-store.com"
```

## خطوات الإصلاح التفصيلية

### الخطوة 1: تحقق من ملف .env
```bash
# تأكد من وجود الملف
ls -la .env

# تحقق من المحتوى
cat .env | grep APP_KEY
```

### الخطوة 2: بناء التطبيق للاختبار
```bash
# نظف البناء السابق
flutter clean
flutter pub get

# ابني للاختبار مع تعطيل Firebase
flutter build apk --debug --dart-define=DISABLE_FIREBASE=true
```

### الخطوة 3: تثبيت التطبيق
```bash
# ثبت على الهاتف
flutter install
```

## المتغيرات المطلوبة

### متغيرات أساسية (مطلوبة):
- `APP_KEY` - مفتاح WooSignal
- `APP_URL` - رابط متجر WooCommerce
- `API_BASE_URL` - رابط API

### متغيرات اختيارية:
- `DISABLE_FIREBASE=true` - لتعطيل Firebase
- `FCM_ENABLED=false` - لتعطيل الإشعارات
- `APP_DEBUG=true` - لتفعيل وضع التطوير

## حل مشاكل شائعة

### 1. خطأ "APP_KEY is null"
```env
# تأكد من أن APP_KEY ليس فارغاً
APP_KEY="your_actual_key_here"
```

### 2. خطأ Firebase
```env
# عطّل Firebase مؤقتاً
DISABLE_FIREBASE=true
FCM_ENABLED=false
```

### 3. خطأ API Connection
```env
# تأكد من صحة رابط API
API_BASE_URL="https://your-correct-domain.com"
```

## للمطورين

### بناء للإنتاج:
```bash
flutter build appbundle --release --dart-define=APP_KEY=your_key
```

### بناء للاختبار:
```bash
flutter build apk --debug --dart-define=DISABLE_FIREBASE=true
```

### فحص السجلات:
```bash
flutter logs
# أو
adb logcat | grep flutter
```

## الدعم
إذا استمرت المشكلة، تحقق من:
1. إعدادات WooSignal Dashboard
2. صحة رابط متجر WooCommerce
3. اتصال الإنترنت
4. أذونات Android Manifest

---
تم إنشاء هذا الدليل لحل مشاكل تعطل تطبيق Label StoreMax