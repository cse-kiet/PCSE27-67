import tensorflow as tf

MODEL_PATH = r"model\disease\best_crop_disease_model.keras"

model = tf.keras.models.load_model(
    MODEL_PATH,
    compile=False
)

print("INPUT:", model.input_shape)
print("OUTPUT:", model.output_shape)
print("PARAMS:", model.count_params())