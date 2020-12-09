import numpy as np
import pandas as pd
import os
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
import math
import scipy.io
import time
import calendar
from datetime import datetime
import urllib
from sklearn.model_selection import train_test_split
#import 
df=pd.read_csv(r"C:\Users\Utilisateur\Desktop\Challenge\genetic_engineering\train_values.csv",index_col=0)
Labels=pd.read_csv(r"C:\Users\Utilisateur\Desktop\Challenge\genetic_engineering\train_labels.csv",index_col=0)
Test=pd.read_csv(r"C:\Users\Utilisateur\Desktop\Challenge\genetic_engineering\test_values.csv",index_col=0)

# sub_df=df.iloc[0:10000,:]#.drop('sequence',axis=1) #/troncate 
# sub_Labels=Labels.iloc[0:10000,:]  #/troncate 
# #validation set
# val_df=df.iloc[10000:12000,:]#.drop('sequence',axis=1)
# val_lab=Labels.iloc[10000:12000,:]

#split for full DATASET
split=int(df.shape[0]*0.80)
sub_df=df.iloc[0:split,:] #/troncate 
val_df=df.iloc[split:,:]
#validation set
sub_Labels=Labels.iloc[0:split,:]  #/troncate 
val_lab=Labels.iloc[split:,:]

     

"""              F U N C T I O N S      """

#padding
def pad_dna(seqs,maxlen):
    padded_seqs = [''] * len(seqs)
    for i in seqs:
        if len(i) > maxlen:
            i = i[:maxlen]
            maxlen = len(i)
    for j in range(len(seqs)):
        if len(seqs[j]) > maxlen:
            seq = seqs[j][0:maxlen]
        else:
            seq = seqs[j]
        padded_seqs[j] = seq + "N" * (maxlen - len(seq))
    return padded_seqs



def convert_onehot2D(list_of_seqs):
    list_of_onehot2D_seqs = np.zeros((len(list_of_seqs),4,len(list_of_seqs[0])))
    nt_dict = {'A':[1,0,0,0],'T':[0,1,0,0],'G':[0,0,1,0],'C':[0,0,0,1], 'N':[0,0,0,0]}
    count = 0
    for seq in list_of_seqs:
        if len(seq) > 1:
            for letter in range(len(seq)):
                for i in range(4):
                    list_of_onehot2D_seqs[count][i][letter] = (nt_dict[seq[letter]])[i]
        count += 1
    return list_of_onehot2D_seqs


"""                      encoding sequences"""
possible_max_len=int(sub_df.sequence.apply(len).median())

sub_df_padded=pad_dna(sub_df.sequence,500)
val_df_padded=pad_dna(val_df.sequence,500)
X_train=np.transpose(convert_onehot2D(sub_df_padded), axes=(0,2,1))
X_val=np.transpose(convert_onehot2D(val_df_padded), axes=(0,2,1))

Y_train=sub_Labels
Y_val=val_lab
"""Works"""   



"""                  C O N V O L U T I O N A L  --  V O I G T                """
import tensorflow as tf
from keras.models import Sequential
from keras.layers.core import Dense, Activation, Dropout, Flatten
from keras.layers.convolutional import Convolution1D
from keras.layers.convolutional import MaxPooling1D
from keras.callbacks import EarlyStopping
from keras.callbacks import ModelCheckpoint
from keras.layers.normalization import BatchNormalization
import time
from keras.optimizers import SGD
from keras.models import load_model 

#network parameters:
dna_bp_length=X_train.shape[1]
num_classes=Y_train.shape[1]
# network hyperparameters
filter_num = 256 
filter_len = 12
num_dense_nodes = 256 
total_epoch = 100 
min_batch_size = 8

start = time.time()
# model specification
model = Sequential()
model.add(Convolution1D(input_dim=4, input_length=dna_bp_length, nb_filter=filter_num, filter_length=filter_len,activation="relu", border_mode ="same"))
model.add(MaxPooling1D(pool_length=dna_bp_length))
model.add(BatchNormalization())
model.add(Flatten())
model.add(Dense(input_dim=filter_num,output_dim=num_dense_nodes))
model.add(Activation("relu"))
model.add(BatchNormalization())
model.add(Dense(output_dim=num_classes))
model.add(Activation("softmax"))
model.compile(loss='categorical_crossentropy',
              optimizer='adam',
              metrics=[tf.keras.metrics.TopKCategoricalAccuracy(10)])
checkpointer = ModelCheckpoint(filepath="checkpoint.hdf5", monitor="val_acc", mode='auto', verbose=1, \
              save_best_only=True)  
early_stopping = EarlyStopping(monitor='val_acc', min_delta=0, patience=10, mode='auto', verbose=1)
print(model.summary())

epoch=5
history = model.fit(X_train, Y_train, batch_size = min_batch_size,
                    validation_data=(X_val, Y_val),
                    nb_epoch=epoch, verbose=1)

    
    
net=history    
#plot
loss=net.history['loss']
acc=net.history['top_k_categorical_accuracy']
val_loss=net.history['val_loss']
val_acc=net.history['val_top_k_categorical_accuracy']

plt.plot(loss,label='loss')
plt.plot(acc,label='accuracy')
plt.plot(val_loss,label='val_loss')
plt.plot(val_acc,label='val_accuracy')
plt.hlines(1,  0,epoch, colors='k', linestyles='--')
plt.legend()
plt.title('CNN')

stop = time.time()

print('computational time for nn :',stop-start,  'seconds')

"""make prediction + submission"""

test_padded=pad_dna(Test.sequence,500)
X_test=np.transpose(convert_onehot2D(test_padded), axes=(0,2,1))

submission= pd.DataFrame(data=model.predict(X_test), 
                             columns=Labels.columns, 
                             index=Test.index)


#submission_test=submission_test.assign(Truth=labID.iloc[0:10,0])

assert submission_format.shape == network.predict(all_test_features).shape
assert (Labels.columns == submission_format.columns).all()

submission.to_csv('Neural_network_submission_18_10.csv')

"""Thoughts
why the fuck val_lose increase ( cross entropy )--> use of another metrics?
Creat a top-k loss function from the one implemented in pytorch ...?

The loss decreases as the training process goes on, except for some fluctuation 
introduced by the mini-batch gradient descent and/or regularization techniques 
like dropout (that introduces random noise).
If the loss decreases, the training process is going well.
The (validation I suppose) accuracy, instead, it's a measure of how good the 
predictions of your model are.
If the model is learning, the accuracy increases. If the model is overfitting,
 instead, the accuracy stops to increase and can even start to decrease.
 If the loss decreases and the accuracy decreases, your model is overfitting.
If the loss increases and the accuracy increase too is because your regularization
 techniques are working well and you're fighting the overfitting problem. 
 This is true only if the loss, then, starts to decrease whilst the accuracy 
 continues to increase. Otherwise, if the loss keep growing your model is 
 diverging and you should look for the cause (usually you're using a too high learning rate value).

    Bay O on CNN parameters
"""

"""              F U N C T I O N S      """

#padding
def pad_dna(seqs,maxlen):
    start = time.time()
    padded_seqs = [''] * len(seqs)
    for i in seqs:
        if len(i) > maxlen:
            i = i[:maxlen]
            maxlen = len(i)
    for j in range(len(seqs)):
        if len(seqs[j]) > maxlen:
            seq = seqs[j][0:maxlen]
        else:
            seq = seqs[j]
        padded_seqs[j] = seq + "N" * (maxlen - len(seq))
    end = time.time()
    return padded_seqs



def convert_onehot2D(list_of_seqs):
    list_of_onehot2D_seqs = np.zeros((len(list_of_seqs),4,len(list_of_seqs[0])))
    nt_dict = {'A':[1,0,0,0],'T':[0,1,0,0],'G':[0,0,1,0],'C':[0,0,0,1], 'N':[0,0,0,0]}
    count = 0
    for seq in list_of_seqs:
        if len(seq) > 1:
            for letter in range(len(seq)):
                for i in range(4):
                    list_of_onehot2D_seqs[count][i][letter] = (nt_dict[seq[letter]])[i]
        count += 1
    return list_of_onehot2D_seqs

