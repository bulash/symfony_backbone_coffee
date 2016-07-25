<?php

namespace AppBundle\Form\Type;

use AppBundle\Entity\User;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\BirthdayType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\RepeatedType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\UrlType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\FormInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

/**
 * Class UserType
 * Manages user info form.
 */
class UserType extends AbstractType
{
    /**
     * Builds the form.
     *
     * @param FormBuilderInterface $builder
     * @param array                $options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('userName', TextType::class, array(
                'label' => 'User name',
                'required' => true,
                'attr' => array(
                    'placeholder' => 'User Name'
                )
            ))
            ->add('userEmail', EmailType::class, array(
                'label' => 'Email',
                'required' => true,
                'attr' => array(
                    'placeholder' => 'Email'
                )
            ))
            ->add('siteUrl', UrlType::class, array(
                'label' => 'Site Url',
                'required' => false,
                'attr' => array(
                    'placeholder' => 'URL'
                )
            ))
            ->add('userBirthday', BirthdayType::class, array(
                'label' => 'Birthday',
                'required' => false,
                'widget' => 'single_text',
                'attr' => array(
                    'placeholder' => 'Birthdate'
                )
            ))
            ->add('userGender', ChoiceType::class, array(
                'choices' => array(User::GENDER_MALE, User::GENDER_FEMALE),
                'label' => 'Gender',
                'required' => true,
                'expanded' => true,
                'multiple' => false
            ))
            ->add('userPhone', TelType::class, array(
                'label' => 'Phone number',
                'required' => false,
                'attr' => array(
                    'placeholder' => 'Phone Number'
                )
            ))
            ->add('userSkill', NumberType::class, array(
                'label' => 'Skill number',
                'required' => false,
                'attr' => array(
                    'placeholder' => 'Skill number'
                )
            ))
            ->add('userAbout', TextareaType::class, array(
                'label' => 'About',
                'required' => false,
                'attr' => array(
                    'placeholder' => 'Enter a brief description of yourself and interest.',
                    'rows' => 1
                )
            ))
            ->add(
                'password',
                RepeatedType::class,
                array(
                    'type' => 'password',
                    'first_options' => array(
                        'label' => 'Password',
                        'attr' => array(
                            'placeholder' => 'Password'
                        )
                    ),
                    'second_options' => array(
                        'label' => 'Repeat Password',
                        'attr' => array(
                            'placeholder' => 'Repeat Password'
                        )
                    ),
                    'invalid_message' => 'Passwords did not match',
                    'mapped' => true,
                    'required' => false,
                )
            )
        ;
    }

    /**
     * {@inheritdoc}
     */
    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults(
            array(
                'data_class' => User::class,
                'validation_groups' => function (FormInterface $form) {
                    $password_check = $form->get('password')->getData();
                    $groups = ['Default'];
                    if ($password_check) {
                        $groups[] = 'password';
                    }

                    return $groups;
                },
            )
        );
    }
}
